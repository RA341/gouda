import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

// This runs in Node.js - Don't use client-side code here (browser APIs, JSX...)

const config: Config = {
    title: 'Gouda',
    tagline: 'Download automation tool for Gouda',
    favicon: 'img/favicon.png',

    // Future flags, see https://docusaurus.io/docs/api/docusaurus-config#future
    future: {
        v4: true, // Improve compatibility with the upcoming Docusaurus v4
    },

    // Set the production url of your site here
    url: 'https://gouda.radn.dev',
    // Set the /<baseUrl>/ pathname under which your site is served
    // For GitHub pages deployment, it is often '/<projectName>/'
    baseUrl: '/',

    // GitHub pages deployment config.
    // If you aren't using GitHub pages, you don't need these.
    organizationName: 'ra341',
    projectName: 'gouda',

    onBrokenLinks: 'warn',
    markdown: {
        hooks: {
            onBrokenMarkdownLinks: 'warn',
            onBrokenMarkdownImages: 'warn',
        },
    },

    // Even if you don't use internationalization, you can use this field to set
    // useful metadata like html lang. For example, if your site is Chinese, you
    // may want to replace "en" with "zh-Hans".
    i18n: {
        defaultLocale: 'en',
        locales: ['en'],
    },

    presets: [
        [
            'classic',
            {
                docs: {
                    sidebarPath: './sidebars.ts',
                    // Please change this to your repo.
                    // Remove this to remove the "edit this page" links.
                    editUrl:
                        'https://github.com/RA341/gouda/tree/main/website/',
                },
                // todo blog
                // blog: {
                //     showReadingTime: true,
                //     feedOptions: {
                //         type: ['rss', 'atom'],
                //         xslt: true,
                //     },
                //     // Please change this to your repo.
                //     // Remove this to remove the "edit this page" links.
                //     editUrl:
                //         'https://github.com/RA341/gouda/tree/main/docs/blog/',
                //     // Useful options to enforce blogging best practices
                //     onInlineTags: 'warn',
                //     onInlineAuthors: 'warn',
                //     onUntruncatedBlogPosts: 'warn',
                // },
                theme: {
                    customCss: './src/css/custom.css',
                },
            } satisfies Preset.Options,
        ],
    ],

    themeConfig: {
        image: 'img/gouda.svg',
        colorMode: {
            defaultMode: 'dark',
        },
        navbar: {
            title: 'Dockman',
            logo: {
                alt: 'Dockman logo',
                src: 'img/gouda.svg',
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
                    docId: 'developers/index',
                    position: 'left',
                    label: 'Developers Guide',
                },
                // {to: '/blog', label: 'Blog', position: 'left'},
                {
                    href: 'https://github.com/ra341/gouda',
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
                            label: 'Tutorial',
                            to: '/docs/guide',
                        },
                    ],
                },
                {
                    title: 'Community',
                    items: [
                        // {
                        //   label: 'Stack Overflow',
                        //   href: 'https://stackoverflow.com/questions/tagged/docusaurus',
                        // },
                        // {
                        //   label: 'Discord',
                        //   href: 'https://discordapp.com/invite/docusaurus',
                        // },
                        {
                            label: 'Github Discussions',
                            href: 'https://github.com/RA341/gouda/discussions',
                        },
                    ],
                },
                // {
                //   title: 'More',
                //   items: [
                //     {
                //       label: 'Blog',
                //       to: '/blog',
                //     },
                //     {
                //       label: 'GitHub',
                //       href: 'https://github.com/facebook/docusaurus',
                //     },
                //   ],
                // },
            ],
            copyright: `Copyright © ${new Date().getFullYear()} Dockman. Built with Docusaurus.`,
        },
        prism: {
            theme: prismThemes.github,
            darkTheme: prismThemes.dracula,
        },
    } satisfies Preset.ThemeConfig,
};

export default config;