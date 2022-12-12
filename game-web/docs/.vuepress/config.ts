import { defaultTheme, defineUserConfig } from 'vuepress'
import { path } from '@vuepress/utils'

export default defineUserConfig({
    lang: 'zh-CN',
    title: 'Run away from covid-19',
    description: 'The War of Viruses',
    theme: defaultTheme(),
    base:'/asm-game/game-web/',
    // alias: {
    //     '@theme/Navbar.vue': path.resolve(__dirname, './components/Navbar.vue'),
    // },
    "host":'localhost',
    "port":8081
})