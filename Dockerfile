# Stage 1: Prepare files
FROM --platform=linux/amd64 busybox AS prep
RUN mkdir /folder && \
    touch /folder/etc-passwd

# Stage 2: Copy files and build final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-nanoserver-1809 AS base

# Copy the files created in the prep stage
COPY --from=prep /folder/etc-passwd /etc/passwd
COPY --from=prep /folder /app
WORKDIR /app

EXPOSE 8080
EXPOSE 8081


