FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["<YourProjectName>.csproj", "."]
RUN dotnet restore "./<YourProjectName>.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "./<YourProjectName>.csproj" -c ${BUILD_CONFIGURATION} -o /app/build
# Publish stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./<YourProjectName>.csproj" -c ${BUILD_CONFIGURATION} -o /app/publish /p:UseAppHost=false
# Final image with application files
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "<YourProjectName>.dll"]
