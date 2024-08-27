FROM mcr.microsoft.com/dotnet/aspnet:8.0-nanoserver-1809 AS base
RUN mkdir /folder &&\
    touch /etc-passwd
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

