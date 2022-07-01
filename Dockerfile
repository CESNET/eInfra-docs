FROM squidfunk/mkdocs-material

LABEL maintainer="adrian@ics.muni.cz"

RUN pip install mkdocs-monorepo-plugin Pygments pymdown-extensions mkdocs-git-committers-plugin-2 mkdocs-git-revision-date-localized-plugin
