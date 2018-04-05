FROM ibmcom/db2express-c

EXPOSE 8080 50000

RUN yum install -y hg | true && \
    wget -O go.tgz https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.tgz && \
    rm -f go.tgz

RUN echo '/entrypoint.sh echo' >> ~/.bash_profile && \
    echo 'GOPATH=/root/go' >> ~/.bash_profile && \
    echo 'PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"' >> ~/.bash_profile && \
    echo 'DB2HOME=/home/db2inst1/sqllib' >> ~/.bash_profile && \
    echo 'export LD_LIBRARY_PATH=$DB2HOME/lib' >> ~/.bash_profile && \
    echo 'export CGO_LDFLAGS=-L$DB2HOME/lib' >> ~/.bash_profile && \
    echo 'export CGO_CFLAGS=-I$DB2HOME/include' >> ~/.bash_profile && \
    echo 'export PATH' >> ~/.bash_profile

ENV GOPATH /root/go
ENV DB2HOME /home/db2inst1/sqllib
ENV LD_LIBRARY_PATH=$DB2HOME/lib
ENV CGO_LDFLAGS=-L$DB2HOME/lib
ENV CGO_CFLAGS=-I$DB2HOME/include
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" && \
    go get -u bitbucket.org/phiggins/db2cli

ENTRYPOINT [""]