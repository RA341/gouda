import {themes as prismThemes} from 'prism-react-renderer';


// With JSDoc @type annotations, IDEs can provide config autocompletion
/** @type {import('@docusaurus/types').DocusaurusConfig} */
(module.exports = {
    title: 'Gouda',
    tagline: 'Download automation tool for Myanonmouse',
    url: 'https://RA341.github.io',
    baseUrl: '/',
    onBrokenLinks: 'throw',
    onBrokenMarkdownLinks: 'warn',
    favicon: 'img/favicon.ico',
    organizationName: 'RA341',
    projectName: 'gouda',
    presets: [
        [
            '@docusaurus/preset-classic',
            /** @type {import('@docusaurus/preset-classic').Options} */
            ({
                docs: {
                    sidebarPath: require.resolve('./sidebars.js'),
                    editUrl: 'https://github.com/RA341/gouda/edit/main/docs',
                },
                blog: {
                    showReadingTime: true,
                    editUrl:
                        'https://github.com/RA341/gouda/edit/main/docs/blog/',
                },
                theme: {
                    customCss: require.resolve('./src/css/custom.css'),
                },
            }),
        ],
    ],

    themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
        ({
            navbar: {
                title: 'Gouda',
                logo: {
                    alt: 'My Site Logo',
                    src: 'img/logo.svg',
                },
                items: [
                    {
                        type: 'doc',
                        docId: 'users/intro',
                        position: 'left',
                        label: 'User Guide',
                    },
                    {
                        type: 'doc',
                        docId: 'developers/intro',
                        position: 'left',
                        label: 'Developers Guide',
                    },

                    // remove this comment to re add blog
                    // {to: '/blog', label: 'Blog', position: 'left'},
                    {
                        href: 'https://github.com/RA341/gouda',
                        label: 'GitHub',
                        position: 'right',
                    },
                ],
            },
            footer: {
                style: 'dark',
                links: [
                    {
                        title: 'Docs',
                        items: [
                            {
                                label: 'Guide',
                                to: '/docs/',
                            },
                        ],
                    },
                    // {
                    //     title: 'Community',
                    //     items: [
                    //         {
                    //             label: 'Discord',
                    //             href: 'https://discord.gg/ChrT2DfcDT',
                    //         },
                    //     ],
                    // },
                    {
                        title: 'More',
                        items: [
                            // {
                            //     label: 'Blog',
                            //     to: '/blog',
                            // },
                            {
                                label: 'GitHub',
                                href: 'https://github.com/RA341/gouda',
                            },
                        ],
                    },
                ],
                copyright: `Copyright © ${new Date().getFullYear()} Gouda. Built with Docusaurus.`,
            },
            prism: {
                theme: prismThemes.github,
                darkTheme: prismThemes.dracula,
            },
        }),
});
