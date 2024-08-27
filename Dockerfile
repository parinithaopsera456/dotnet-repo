FROM --platform=linux/amd64 busybox as prep

RUN mkdir /folder &&\
    touch /etc-passwd
COPY --from=prep /folder /workspace
COPY --from=prep /etc-passwd /etc/passwd

FROM mcr.microsoft.com/dotnet/aspnet:8.0-nanoserver-1809 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081


