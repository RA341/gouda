import type {ComponentProps, ComponentType, ReactNode} from 'react';
import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

type FeatureItem = {
    title: string;
    Svg?: ComponentType<ComponentProps<'svg'>>;
    description: ReactNode;
};

const FeatureList: FeatureItem[] = [
    {
        title: 'Direct Downloads',
        description: (
            <>
                Download your books directly to your device without manual torrent management.
                Gouda handles all the complexity behind the scenes.
            </>
        ),
    },
    {
        title: 'Smart Search',
        description: (
            <>
                Search the entire MyAnonmouse library and download books instantly with one click.
                Find exactly what you&apos;re looking for quickly and efficiently.
            </>
        ),
    },
    {
        title: 'Mobile App',
        description: (
            <>
                Access all features on-the-go with our iOS and Android apps for downloading on the go.
                Manage your library from anywhere, anytime.
            </>
        ),
    },
];

function Feature({title, Svg, description}: FeatureItem) {
    return (
        <div className={clsx('col col--4')}>
            <div className="text--center">
                {(Svg) && <Svg className={styles.featureSvg} role="img"/>}
            </div>
            <div className="text--center padding-horiz--md">
                <Heading as="h3">{title}</Heading>
                <p>{description}</p>
            </div>
        </div>
    );
}

export default function HomepageFeatures(): ReactNode {
    return (
        <section className={styles.features}>
            <div className="container">
                <div className="row">
                    {FeatureList.map((props, idx) => (
                        <Feature key={idx} {...props} />
                    ))}
                </div>
            </div>
        </section>
    );
}
