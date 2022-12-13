import { defaultTheme, defineUserConfig } from 'vuepress'
import { path } from '@vuepress/utils'

export default defineUserConfig({
    lang: 'zh-CN',
    title: 'Cyberpunk Covid-19',
    description: 'Cyberpunk Covid-19',
    theme: defaultTheme(),
    base:'/asm-game/',
    // dest: path.resolve(__dirname, '../../dist/vuepress'),
    // alias: {
    //     '@theme/Navbar.vue': path.resolve(__dirname, './components/Navbar.vue'),
    // },
    "host":'localhost',
    "port":8081
})