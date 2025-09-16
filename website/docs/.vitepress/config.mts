import {defineConfig} from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
    title: "Gouda",
    description: "Download automation tool for Myanonmouse",
    themeConfig: {
        // https://vitepress.dev/reference/default-theme-config
        nav: [
            {text: 'Home', link: '/'},
            {text: 'Guide', link: '/guide/'},
            {text: 'Developers', link: '/developers/'}
        ],

        sidebar: {
            '/guide/': {
                base: '/guide/', items: [
                    {text: 'Category', link: '/category.md'},
                    {text: 'One', link: '/guide/ca'},
                    {text: 'Two', link: '/guide/two'}
                ]
            },

            // Auto-generate sidebar for /developers/ section
            '/developers/': {base: '/developers/', items: 'auto'},

            // Auto-generate sidebar for root
            '/': {base: '/', items: 'auto'}
        },

        socialLinks: [
            {icon: 'github', link: 'https://github.com/vuejs/vitepress'}
        ]
    }
})
