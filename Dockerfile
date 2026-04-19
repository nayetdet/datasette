FROM datasetteproject/datasette:latest
ARG PORT=6767
ENV PORT=${PORT}

RUN datasette install \
    datasette-plot \
    datasette-vega \
    datasette-search-all

WORKDIR /app
EXPOSE ${PORT}
VOLUME ["/app/data"]
CMD ["sh", "-c", "datasette -h 0.0.0.0 -p $PORT /app/data/database.sqlite"]
