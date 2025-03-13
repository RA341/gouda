import React from 'react';
import useBaseUrl from '@docusaurus/useBaseUrl';
import { Redirect } from '@docusaurus/router';

export default function Home() {
    const docsUrl = useBaseUrl('/docs/');
    return <Redirect to={docsUrl} />;
}
