# **Flight Tracker App**

Um aplicativo Flutter para gerenciar o histórico de voos, com funcionalidades de exibição de voos passados, detalhamento de informações e previsão de status de voos concluídos.

---

## **Tabela de Conteúdos**

- [Sobre o Projeto](#sobre-o-projeto)
- [Funcionalidades](#funcionalidades)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Configuração do Projeto](#configuração-do-projeto)
- [Como Executar o Projeto](#como-executar-o-projeto)
- [Pendências](#pendências)
- [Contribuindo](#contribuindo)
- [Grupo](#grupo)
- [Descrição do Domínio](#descrição-do-domínio)
- [Base de Dados](#base-de-dados)
- [Informações da Base de Dados](#informações-da-base-de-dados)

---

## **Sobre o Projeto**

O **Flight Tracker App** é um aplicativo desenvolvido em **Flutter** que permite aos usuários consultar seu histórico de voos, visualizar os detalhes de voos passados, e até prever o status de voos concluídos. O app utiliza o **Provider** para gerenciamento de estado e **http** para fazer requisições de dados, permitindo a exibição dinâmica e interativa das informações de voo.

---

## **Funcionalidades**

- **Histórico de Voos:** Exibe uma lista de voos passados, com informações sobre partida, chegada e status do voo.
- **Detalhes do Voo:** Ao selecionar um voo, o usuário pode visualizar detalhes sobre a partida, chegada e duração do voo.
- **Previsão de Status:** Para voos concluídos, o app faz uma previsão sobre o status do voo (por exemplo, "Voo Realizado" ou "Voo Cancelado").
- **Conclusão de Voos:** O usuário pode finalizar voos não realizados, selecionando as datas de partida e chegada para atualizar o status.

---

## **Tecnologias Utilizadas**

- **Flutter**: Framework para desenvolvimento de aplicativos móveis.
- **Provider**: Gerenciamento de estado para Flutter.
- **http**: Biblioteca para realizar requisições HTTP.
- **intl**: Biblioteca para formatação de datas e horários.

---

## **Configuração do Projeto**

### **Dependências**

Certifique-se de ter as seguintes dependências no seu arquivo `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  http: ^0.13.3
  intl: ^0.17.0
