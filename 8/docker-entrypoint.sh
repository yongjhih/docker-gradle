#!/usr/bin/env bash

# Copy files from ${GRADLE_REF} into ${GRADLE_CONFIG}
# So the initial ~/.gradle is set with expected content.
# Don't override, as this is just a reference setup
copy_reference_file() {
  root="${1}"
  f="${2%/}"
  b="${f%.override}"
  echo "$f" >> "$COPY_REFERENCE_FILE_LOG"
  rel="$(echo $f | sed -e "s#${root}##")" # path relative to /usr/share/gradle/ref/
  dir=$(dirname "${b}")
  echo " $f -> $rel" >> "$COPY_REFERENCE_FILE_LOG"
  if [[ ! -e ${GRADLE_CONFIG}/${rel} || $f = *.override ]]
  then
    echo "copy $rel to ${GRADLE_CONFIG}" >> "$COPY_REFERENCE_FILE_LOG"
    mkdir -p "${GRADLE_CONFIG}/$(dirname ${rel})"
    cp -r "${f}" "${GRADLE_CONFIG}/${rel}";
  fi;
}
export -f copy_reference_file
touch "${COPY_REFERENCE_FILE_LOG}" || (echo "Can not write to ${COPY_REFERENCE_FILE_LOG}. Wrong volume permissions?" && exit 1)
echo "--- Copying files at $(date)" >> "$COPY_REFERENCE_FILE_LOG"
find ${GRADLE_REF}/ -type f -exec bash -c "copy_reference_file ${GRADLE_REF}/ '{}'" \;

exec "$@"
