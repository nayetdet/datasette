FROM datasetteproject/datasette:latest
ARG PORT=8001
ENV PORT=${PORT}

RUN datasette install \
    datasette-search-all \
    datasette-vega

WORKDIR /app
EXPOSE ${PORT}
VOLUME ["/app/data"]
CMD ["sh", "-c", "datasette -h 0.0.0.0 -p $PORT /app/data/database.sqlite"]
