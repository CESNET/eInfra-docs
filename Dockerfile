FROM squidfunk/mkdocs-material

LABEL maintainer="adrian@ics.muni.cz"

RUN pip install mkdocs-monorepo-plugin Pygments pymdown-extensions
