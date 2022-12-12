<template><div><h2 id="单人练习模式" tabindex="-1"><a class="header-anchor" href="#单人练习模式" aria-hidden="true">#</a> 单人练习模式</h2>
<p>已经有的：
绿色病毒
红色病毒
盾牌（金币使用)
加速药水
减速药水
子弹
go_togather{//玩家进行了玩耍
player1
player2
//查看状态 根据规则修改
}
player1----mask
{
player2.is_mask = 1000
}</p>
<p>if (player1.is_mask&gt;0) {
draw_mask
player1.is_mask--;
}
player{
base
...
state {
免疫 [暴露] 无症状 感染
}
is_mask 1000
is_fever 0/1</p>
<p>}</p>
<h2 id="双人竞技模式a-b玩家" tabindex="-1"><a class="header-anchor" href="#双人竞技模式a-b玩家" aria-hidden="true">#</a> 双人竞技模式a，b玩家</h2>
<p>胜利条件:存活优先，均存活比exp</p>
<p>需要改变的：</p>
<pre><code>盾牌（金币）-&gt; 药

增加玩家属性{HP}-&gt;{exp-&gt;(), HP}

玩家四种状态{免疫 [暴露] 无症状 感染} [initial]

不做加速减速效果，总体初始速度提高


1：不同状态下的玩家接触到不同的道具的效果
   
    红色病毒: {
        非感染，非免疫{
            HP-1
            状态改为感染期
        }
    }
    绿色病毒{
        非感染，非免疫{
            exp+1
            状态改为无症状
        }
    }
    药{
        非免疫{
            状态改为免疫期
        }
        仅当感染{
            HP+1
        }
    }


PlayerOne:ptr Subject  PlayerTwo:ptr Subject
2：不同状态下的玩家互相接触的效果
    聚餐：a玩家吃到一个“聚餐”道具的时候，{
        1.交互显示：显示一个图像，
        2.根据两者状态修改玩家属性 {
            暴露期-无症状：吃一个绿病毒
            暴露期-感染 : 吃一个红病毒
            无症状-感染： 吃一个红病毒
        }
    }   
    口罩：a玩家{
        b遮挡一个玩家视野3s
    }
    测温计：a玩家{
        b玩家左右方向键置反3s
    }

3.状态的自动转换{
    任意一个状态最多持续5s， 5s后均转换为暴露期。
}
</code></pre>
</div></template>


