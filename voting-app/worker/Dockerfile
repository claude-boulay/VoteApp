FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /application

COPY Worker.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c release --self-contained false --no-restore -o /publish


FROM mcr.microsoft.com/dotnet/runtime:7.0

WORKDIR /application

COPY --from=build /publish .

ENTRYPOINT ["dotnet", "Worker.dll"]