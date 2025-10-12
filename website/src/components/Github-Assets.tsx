import React, {useEffect, useState} from 'react';
import {Calendar, Download, HardDrive, Package, Search} from 'lucide-react';

export default function GitHubReleaseViewer() {
    const [releases, setReleases] = useState([]);
    const [selectedVersion, setSelectedVersion] = useState('');
    const [searchTerm, setSearchTerm] = useState('');
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    // Replace these with your actual GitHub username and repo name
    const GITHUB_USER = 'ra341';
    const GITHUB_REPO = 'gouda';

    useEffect(() => {
        fetchReleases();
    }, []);

    const fetchReleases = async () => {
        try {
            setLoading(true);
            const response = await fetch(
                `https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases`
            );

            if (!response.ok) throw new Error('Failed to fetch releases');

            const data = await response.json();
            setReleases(data);
            if (data.length > 0) {
                setSelectedVersion(data[0].tag_name);
            }
            setError(null);
        } catch (err) {
            setError(err.message);
        } finally {
            setLoading(false);
        }
    };

    const formatBytes = (bytes) => {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i];
    };

    const formatDate = (dateString) => {
        return new Date(dateString).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    };

    const parseAssetName = (name) => {
        // Parse gouda-<flavour>-<platform>-<arch>
        const goudaMatch = name.match(/^gouda-([^-]+)-([^-]+)-([^-]+)/);
        if (goudaMatch) {
            return {
                type: 'gouda',
                flavour: goudaMatch[1],
                platform: goudaMatch[2],
                arch: goudaMatch[3],
                displayName: `Gouda Server - ${goudaMatch[1]} (${goudaMatch[2]}-${goudaMatch[3]})`
            };
        }

        // Parse brie-<platform>
        const brieMatch = name.match(/^brie-([^-]+)/);
        if (brieMatch) {
            return {
                type: 'brie',
                platform: brieMatch[1],
                displayName: `Brie Client - ${brieMatch[1].charAt(0).toUpperCase() + brieMatch[1].slice(1)}`
            };
        }

        return {
            type: 'other',
            displayName: name
        };
    };

    const selectedRelease = releases.find(r => r.tag_name === selectedVersion);

    const filteredAssets = selectedRelease?.assets.filter(asset => {
        const parsed = parseAssetName(asset.name);
        const searchLower = searchTerm.toLowerCase();
        return (
            asset.name.toLowerCase().includes(searchLower) ||
            parsed.displayName.toLowerCase().includes(searchLower) ||
            (parsed.platform && parsed.platform.toLowerCase().includes(searchLower)) ||
            (parsed.arch && parsed.arch.toLowerCase().includes(searchLower)) ||
            (parsed.flavour && parsed.flavour.toLowerCase().includes(searchLower))
        );
    }) || [];

    const goudaAssets = filteredAssets.filter(a => parseAssetName(a.name).type === 'gouda');
    const brieAssets = filteredAssets.filter(a => parseAssetName(a.name).type === 'brie');
    const otherAssets = filteredAssets.filter(a => parseAssetName(a.name).type === 'other');

    if (loading) {
        return (
            <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 p-8">
                <div className="max-w-6xl mx-auto">
                    <div className="flex items-center justify-center h-64">
                        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
                    </div>
                </div>
            </div>
        );
    }

    if (error) {
        return (
            <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 p-8">
                <div className="max-w-6xl mx-auto">
                    <div className="bg-red-50 border border-red-200 rounded-lg p-6">
                        <h3 className="text-red-800 font-semibold mb-2">Error Loading Releases</h3>
                        <p className="text-red-600">{error}</p>
                        <p className="text-sm text-red-500 mt-2">
                            Make sure to update GITHUB_USER and GITHUB_REPO in the component code.
                        </p>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 p-8">
            <div className="max-w-6xl mx-auto">
                <div className="mb-8">
                    <h1 className="text-4xl font-bold text-slate-800 mb-2">Project Downloads</h1>
                    <p className="text-slate-600">Download Gouda server and Brie client releases</p>
                </div>

                {/* Controls */}
                <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        {/* Search Bar */}
                        <div className="relative">
                            <Search
                                className="absolute left-3 top-1/2 transform -translate-y-1/2 text-slate-400 w-5 h-5"/>
                            <input
                                type="text"
                                placeholder="Search assets by name, platform, or architecture..."
                                value={searchTerm}
                                onChange={(e) => setSearchTerm(e.target.value)}
                                className="w-full pl-10 pr-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                            />
                        </div>

                        {/* Version Selector */}
                        <div>
                            <select
                                value={selectedVersion}
                                onChange={(e) => setSelectedVersion(e.target.value)}
                                className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                            >
                                {releases.map(release => (
                                    <option key={release.id} value={release.tag_name}>
                                        {release.tag_name} {release.prerelease ? '(Pre-release)' : ''}
                                    </option>
                                ))}
                            </select>
                        </div>
                    </div>
                </div>

                {/* Source Code Download */}
                {selectedRelease && (
                    <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
                        <h2 className="text-xl font-semibold text-slate-800 mb-4 flex items-center gap-2">
                            <Package className="w-5 h-5"/>
                            Source Code
                        </h2>
                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                            <a
                                href={selectedRelease.zipball_url}
                                className="flex items-center justify-between px-4 py-3 bg-slate-50 hover:bg-slate-100 border border-slate-200 rounded-lg transition-colors"
                            >
                                <span className="font-medium text-slate-700">ZIP Archive</span>
                                <Download className="w-4 h-4 text-slate-600"/>
                            </a>
                            <a
                                href={selectedRelease.tarball_url}
                                className="flex items-center justify-between px-4 py-3 bg-slate-50 hover:bg-slate-100 border border-slate-200 rounded-lg transition-colors"
                            >
                                <span className="font-medium text-slate-700">TAR.GZ Archive</span>
                                <Download className="w-4 h-4 text-slate-600"/>
                            </a>
                        </div>
                    </div>
                )}

                {/* Gouda Server Assets */}
                {goudaAssets.length > 0 && (
                    <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
                        <h2 className="text-xl font-semibold text-slate-800 mb-4">Gouda Server Builds</h2>
                        <div className="space-y-2">
                            {goudaAssets.map(asset => {
                                const parsed = parseAssetName(asset.name);
                                return (
                                    <div key={asset.id}
                                         className="flex items-center justify-between p-4 bg-slate-50 hover:bg-slate-100 border border-slate-200 rounded-lg transition-colors">
                                        <div className="flex-1">
                                            <h3 className="font-medium text-slate-800">{parsed.displayName}</h3>
                                            <div className="flex items-center gap-4 mt-1 text-sm text-slate-600">
                        <span className="flex items-center gap-1">
                          <HardDrive className="w-4 h-4"/>
                            {formatBytes(asset.size)}
                        </span>
                                                <span className="flex items-center gap-1">
                          <Calendar className="w-4 h-4"/>
                                                    {formatDate(asset.updated_at)}
                        </span>
                                            </div>
                                        </div>
                                        <a
                                            href={asset.browser_download_url}
                                            className="ml-4 px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition-colors flex items-center gap-2"
                                        >
                                            <Download className="w-4 h-4"/>
                                            Download
                                        </a>
                                    </div>
                                );
                            })}
                        </div>
                    </div>
                )}

                {/* Brie Client Assets */}
                {brieAssets.length > 0 && (
                    <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
                        <h2 className="text-xl font-semibold text-slate-800 mb-4">Brie Client Builds</h2>
                        <div className="space-y-2">
                            {brieAssets.map(asset => {
                                const parsed = parseAssetName(asset.name);
                                return (
                                    <div key={asset.id}
                                         className="flex items-center justify-between p-4 bg-slate-50 hover:bg-slate-100 border border-slate-200 rounded-lg transition-colors">
                                        <div className="flex-1">
                                            <h3 className="font-medium text-slate-800">{parsed.displayName}</h3>
                                            <div className="flex items-center gap-4 mt-1 text-sm text-slate-600">
                        <span className="flex items-center gap-1">
                          <HardDrive className="w-4 h-4"/>
                            {formatBytes(asset.size)}
                        </span>
                                                <span className="flex items-center gap-1">
                          <Calendar className="w-4 h-4"/>
                                                    {formatDate(asset.updated_at)}
                        </span>
                                            </div>
                                        </div>
                                        <a
                                            href={asset.browser_download_url}
                                            className="ml-4 px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg transition-colors flex items-center gap-2"
                                        >
                                            <Download className="w-4 h-4"/>
                                            Download
                                        </a>
                                    </div>
                                );
                            })}
                        </div>
                    </div>
                )}

                {/* Other Assets */}
                {otherAssets.length > 0 && (
                    <div className="bg-white rounded-lg shadow-sm p-6">
                        <h2 className="text-xl font-semibold text-slate-800 mb-4">Other Assets</h2>
                        <div className="space-y-2">
                            {otherAssets.map(asset => (
                                <div key={asset.id}
                                     className="flex items-center justify-between p-4 bg-slate-50 hover:bg-slate-100 border border-slate-200 rounded-lg transition-colors">
                                    <div className="flex-1">
                                        <h3 className="font-medium text-slate-800">{asset.name}</h3>
                                        <div className="flex items-center gap-4 mt-1 text-sm text-slate-600">
                      <span className="flex items-center gap-1">
                        <HardDrive className="w-4 h-4"/>
                          {formatBytes(asset.size)}
                      </span>
                                            <span className="flex items-center gap-1">
                        <Calendar className="w-4 h-4"/>
                                                {formatDate(asset.updated_at)}
                      </span>
                                        </div>
                                    </div>
                                    <a
                                        href={asset.browser_download_url}
                                        className="ml-4 px-4 py-2 bg-slate-600 hover:bg-slate-700 text-white rounded-lg transition-colors flex items-center gap-2"
                                    >
                                        <Download className="w-4 h-4"/>
                                        Download
                                    </a>
                                </div>
                            ))}
                        </div>
                    </div>
                )}

                {filteredAssets.length === 0 && (
                    <div className="bg-white rounded-lg shadow-sm p-12 text-center">
                        <p className="text-slate-500">No assets found matching your search.</p>
                    </div>
                )}
            </div>
        </div>
    );
}