FROM alpine:3.5 AS BUILDER

WORKDIR /odp
RUN apk update && \
	apk add git && \
    git clone https://github.com/OpenDictionaryProject/Databases.git


FROM datasetteproject/datasette:latest

RUN mkdir /db
COPY --from=BUILDER /odp/Databases/dist/English/dictionary.db /db

ENTRYPOINT ["datasette", "/db/dictionary.db", "--setting max_returned_rows 5000"]
