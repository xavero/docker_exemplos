FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /workspace

# copia arquivos dos projetos e faz restore dos pacotes nuget
COPY aspnetcoreapp.sln .
COPY source/aspnetcoreapp.csproj source/
COPY tests/aspnetcoreappTests1.csproj tests/

RUN dotnet restore

# copia o resto do fonte e faz o build
COPY ./ ./
RUN dotnet build -c release --no-restore

# executa os testes
RUN dotnet test --logger:trx -c release --no-build

RUN dotnet publish -c release --no-build -o /app --no-restore

# usa uma imagem sem o SDK do .net para rodar a aplicação
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app ./

ENTRYPOINT ["dotnet", "aspnetcoreapp.dll"]
