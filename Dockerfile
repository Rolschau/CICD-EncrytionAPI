# Use the official .NET Core SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy the project file and restore dependencies
COPY EncryptionAPI/EncryptionAPI.csproj ./
RUN dotnet restore

# Copy the remaining source code
COPY . ./

# Build the application
RUN dotnet build --configuration Release -o /app/build

# Run tests (if needed)
# RUN dotnet test

# Build the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build-env /app/build .
ENTRYPOINT ["dotnet", "EncryptionAPI.dll"]
