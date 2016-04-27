#!/usr/bin/env bash

set -e

latest='jdk-8'

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

url='git://github.com/yongjhih/docker-gradle'

generate-version() {
	local version=$1
	local branch=$2
	local branch_suffix=""

	if [ "$branch" != 'master' ]; then
		branch_suffix="-${branch}"
	fi

	commit="$(git log -1 --format='format:%H' "$branch" -- "$version")"
	
	gradleVersion="$(grep -m1 'ENV GRADLE_VERSION ' "$version/Dockerfile" | cut -d' ' -f3)"
	
	versionAliases=()
	while [ "${gradleVersion%[.-]*}" != "$gradleVersion" ]; do
		versionAliases+=( $gradleVersion-$version )
		if [ "$version" = "$latest" ]; then
			versionAliases+=( $gradleVersion )
		fi
		gradleVersion="${gradleVersion%[.-]*}"
	done
	versionAliases+=( $gradleVersion-$version )
	if [ "$version" = "$latest" ]; then
		versionAliases+=( $gradleVersion latest )
	fi
	
	echo
	for va in "${versionAliases[@]}"; do
		if [ "$branch" != 'master' ] && [ "$va" = 'latest' ]; then
			echo "${branch}: ${url}@${commit} $version"
		else
			echo "${va}${branch_suffix}: ${url}@${commit} $version"
		fi
	done
	
	#for variant in onbuild; do
	#	commit="$(git log -1 --format='format:%H' "$branch" -- "$version/$variant")"
	#	echo
	#	for va in "${versionAliases[@]}"; do
	#		if [ "$va" = 'latest' ]; then
	#			va="${variant}${branch_suffix}"
	#		else
	#			va="$va-${variant}${branch_suffix}"
	#		fi
	#		echo "$va: ${url}@${commit} $version/$variant"
	#	done
	#done
}

echo '# maintainer: Andrew Chen <yongjhih@gmail.com> (@yongjhih)'

versions=( jdk-*/ )
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do
	for branch in master; do
		if ! ( [ "$version" == 'jdk-9' ] && [ "$branch" == 'alpine' ] ); then # no base image for jdk-9-alpine yet
			generate-version "$version" "$branch"
		fi
	done
done
