if [ "$1" == "" ]; then
  echo "Missing version number"
  exit
fi
if [ "$2" == "" ]; then
  echo "Missing release type"
  exit
fi

echo "Prepare version file"
GITHUB_SHA=`git rev-parse HEAD`
echo ":release-type: $2" > version.adoc
echo ":ref-name: $1" >> version.adoc
echo ":commit-sha: `echo $GITHUB_SHA | cut -c1-7`" >> version.adoc

echo "Convert special characters"
find */* -type f -name "*.adoc" -exec sed -i 's/&commat;/@/g; s/&deg;/°/g; s/&lowbar;/_/g; s/&sup2;/²/g; s/&times;/×/g' {} +

echo "Convert svgs"
find */* -type f -name "*.adoc" -exec sed -i 's/.svg/.png/g;' {} +

echo "Build Datasheet"
docker run --rm -u 1000:1000 -v ${PWD}:/documents asciidoctor/docker-asciidoctor asciidoctor-pdf -a build-type=pdf -r asciidoctor-diagram -r asciidoctor-kroki -D outputs/datasheet -o ch32v103_ds.pdf datasheet/index.adoc