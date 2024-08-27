# # Base image for the application runtime
# FROM mcr.microsoft.com/dotnet/aspnet:8.0-nanoserver-1809 AS base
# WORKDIR /app
# EXPOSE 8080
# EXPOSE 8081

# # Build stage
# FROM mcr.microsoft.com/dotnet/aspnet:8.0-nanoserver-1809 AS base
# ARG BUILD_CONFIGURATION=Release
# WORKDIR /src
# COPY ["dotnet-repo.csproj", "."]
# RUN dotnet restore "./dotnet-repo.csproj"
# COPY . .
# WORKDIR "/src/."
# RUN dotnet build "./dotnet-repo.csproj" -c ${BUILD_CONFIGURATION} -o /app/build

# # Publish stage
# FROM build AS publish
# ARG BUILD_CONFIGURATION=Release
# RUN dotnet publish "./dotnet-repo.csproj" -c ${BUILD_CONFIGURATION} -o /app/publish /p:UseAppHost=false

# # Final image with application files
# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "dotnet-repo.dll"]

# Base image for the application runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0-nanoserver-1809 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0-nanoserver-1809 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["dotnet-repo.csproj", "."]
RUN dotnet restore "./dotnet-repo.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "./dotnet-repo.csproj" -c ${BUILD_CONFIGURATION} -o /app/build

# Publish stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./dotnet-repo.csproj" -c ${BUILD_CONFIGURATION} -o /app/publish /p:UseAppHost=false

# Final image with application files
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "dotnet-repo.dll"]

