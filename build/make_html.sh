echo "Build index page"
docker run --rm -u 1000:1000 -v ${PWD}:/documents asciidoctor/docker-asciidoctor asciidoctor -b html5 -r asciidoctor-diagram -r asciidoctor-kroki -D outputs index.adoc

echo "Build Datasheet"
docker run --rm -u 1000:1000 -v ${PWD}:/documents asciidoctor/docker-asciidoctor asciidoctor -b html5 -r asciidoctor-diagram -r asciidoctor-kroki -D outputs/datasheet datasheet/index.adoc

echo "Copy resources"
mkdir -p outputs/resources/img
cp resources/img/*.svg outputs/resources/img/