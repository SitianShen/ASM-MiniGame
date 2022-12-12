#include <windows.h>
#include <objidl.h>
#include <gdiplus.h>
// #include <stdio.h>
using namespace Gdiplus;
#pragma comment (lib,"Gdiplus.lib")
#define ID_TIMER 101

Image* m_pImage;

LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);

INT WINAPI WinMain(HINSTANCE hInstance, HINSTANCE, PSTR, INT iCmdShow)
{
    HWND                hWnd;
    MSG                 msg;
    WNDCLASS            wndClass;
    GdiplusStartupInput gdiplusStartupInput;
    ULONG_PTR           gdiplusToken;

    // Initialize GDI+.
    GdiplusStartup(&gdiplusToken, &gdiplusStartupInput, NULL);

    wndClass.style = CS_HREDRAW | CS_VREDRAW;
    wndClass.lpfnWndProc = WndProc;
    wndClass.cbClsExtra = 0;
    wndClass.cbWndExtra = 0;
    wndClass.hInstance = hInstance;
    wndClass.hIcon = LoadIcon(NULL, IDI_APPLICATION);
    wndClass.hCursor = LoadCursor(NULL, IDC_ARROW);
    wndClass.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
    wndClass.lpszMenuName = NULL;
    wndClass.lpszClassName = TEXT("GettingStarted");

    RegisterClass(&wndClass);

    hWnd = CreateWindow(
        TEXT("GettingStarted"),   // window class name
        TEXT("Getting Started"),  // window caption
        WS_OVERLAPPEDWINDOW,      // window style
        CW_USEDEFAULT,            // initial x position
        CW_USEDEFAULT,            // initial y position
        CW_USEDEFAULT,            // initial x size
        CW_USEDEFAULT,            // initial y size
        NULL,                     // parent window handle
        NULL,                     // window menu handle
        hInstance,                // program instance handle
        NULL);                    // creation parameters

    ShowWindow(hWnd, iCmdShow);
    UpdateWindow(hWnd);

    while (GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    GdiplusShutdown(gdiplusToken);
    return msg.wParam;
}  // WinMain


PropertyItem* m_pItem = 0;
UINT m_iCurrentFrame = 0;
UINT m_FrameCount = 0;

LRESULT CALLBACK WndProc(HWND hWnd, UINT message,
    WPARAM wParam, LPARAM lParam)
{
    HDC          hdc;
    PAINTSTRUCT  ps;
    Image* m_pImage = new Image(L"giphy.gif");
   
    switch (message)
    {
    case WM_CREATE:
    {
        //First of all we should get the number of frame dimensions
        //Images considered by GDI+ as:
        //frames[animation_frame_index][how_many_animation];
        UINT count = m_pImage->GetFrameDimensionsCount();

        //Now we should get the identifiers for the frame dimensions 
        GUID* m_pDimensionIDs = new GUID[count];
        m_pImage->GetFrameDimensionsList(m_pDimensionIDs, count);

        //For gif image , we only care about animation set#0
        WCHAR strGuid[40];
        StringFromGUID2(m_pDimensionIDs[0], strGuid, 40);
        m_FrameCount = m_pImage->GetFrameCount(&m_pDimensionIDs[0]);

        //PropertyTagFrameDelay is a pre-defined identifier 
        //to present frame-delays by GDI+
        UINT TotalBuffer = m_pImage->GetPropertyItemSize(PropertyTagFrameDelay);
        m_pItem = (PropertyItem*)malloc(TotalBuffer);
        m_pImage->GetPropertyItem(PropertyTagFrameDelay, TotalBuffer, m_pItem);
    }
    break;
    case WM_TIMER: {
        //Because there will be a new delay value
        KillTimer(hWnd, ID_TIMER);
        //Change Active frame
        GUID Guid = FrameDimensionTime;
        m_pImage->SelectActiveFrame(&Guid, m_iCurrentFrame);
        //New timer
        SetTimer(hWnd, ID_TIMER, ((UINT*)m_pItem[0].value)[m_iCurrentFrame] * 10, NULL);
        //Again move to the next
        m_iCurrentFrame = (++m_iCurrentFrame) % m_FrameCount;
        InvalidateRect(hWnd, NULL, FALSE);
        break;
    }
    case WM_PAINT:
    {
        HDC hdc;
        PAINTSTRUCT ps;
        hdc = BeginPaint(hWnd, &ps);

        Graphics graphics(hdc);

        //Set Current Frame at #0
        GUID Guid = FrameDimensionTime;
        m_pImage->SelectActiveFrame(&Guid, m_iCurrentFrame);

        //Use Timer
        //NOTE HERE: frame-delay values should be multiply by 10
        SetTimer(hWnd, ID_TIMER, ((UINT*)m_pItem[0].value)[m_iCurrentFrame] * 10, (TIMERPROC)NULL);

        //Move to the next frame
        ++m_iCurrentFrame;
        InvalidateRect(hWnd, NULL, FALSE);

        //Finally simply draw
        graphics.DrawImage(m_pImage, 120, 120, 800, 600);

        EndPaint(hWnd, &ps);
        break;
    }
    case WM_DESTROY:
        PostQuitMessage(0);
        return 0;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
} // WndProc

// void printHelloWorld(){
//     printf("hello world!");
//     return;
// }

// int main(){ 
//     printHelloWorld();
//     return 0;
// }