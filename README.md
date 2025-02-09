
<div align="center"><h1>Carangas 🚗</div></h1>
  
## Sobre o Projeto 📝
Carangas é um aplicativo de gerenciamento de carros que permite ao usuário visualizar, adicionar, editar e excluir carros de uma lista. O aplicativo se conecta a duas APIs remotas para carregar e salvar dados de carros e marcas de carros.

## Estrutura de Pastas 📁
```css

Carangas

├── Controllers
│   ├── AddEditViewController.swift
│   ├── CarViewController.swift
│   └── CarsTableViewController.swift
├── Models
│   ├── Car.swift
│   └── Brand.swift
├── API
│   └── REST.swift
├── Views
│   ├── Main.storyboard
│   └── LaunchScreen.swift
└── Supporting Files
    ├── Info.plist
    └── Assets.xcassets
```

## Estrutura do projeto 📁

### Controllers
- <b>CarsTableViewController.swift:</b> Controlador responsável por gerenciar a tela que lista todos os carros disponíveis.
- <b>CarViewController.swift:</b> Controlador responsável por gerenciar a tela que mostra os detalhes de um carro específico.
- <b>AddEditViewController.swift:</b> Controlador responsável por gerenciar a tela de adição e edição de carros.

### Models
- <b>Car.swift:</b> Modelo que representa um carro.
- <b>Brand.swift:</b> Modelo que representa uma marca de carro.

### Services
- <b>REST.swift:</b> Classe que gerencia todas as requisições REST feitas pelo aplicativo. Inclui métodos para carregar, salvar, atualizar e deletar carros, além de carregar marcas.

## Link das APIs Utilizadas 🌐
- API de Carros: <a href="https://carangas.herokuapp.com/cars" target="_blank">Carangas API</a>
- API de Marcas de Carros: <a href="https://parallelum.com.br/fipe/api/v1/carros/marcas" target="_blank">Parallelum API</a>

 ## 🚀 Como Rodar

### Clone o repositório:

```sh
git clone https://github.com/vrortega/Carangas.git
cd Carangas
```

* **Abra o Projeto no Xcode:**

Navegue até o arquivo `Carangas.xcodeproj` e abra-o com o Xcode.

* **Instale as Dependências:**

Se o projeto utilizar CocoaPods, execute `pod install` para instalar as dependências necessárias.

* **Compile e Rode o Projeto:**

Pressione `Cmd + R` ou clique no botão de rodar no Xcode.

# 📖 Referência
Projeto desenvolvido como parte do <a href="https://www.udemy.com/course/curso-completo-de-desenvolvimento-ios11swift4" target="_blank">
curso de desenvolvimento iOS, do Desenvolvedor Eric Alves Brito</a>.
