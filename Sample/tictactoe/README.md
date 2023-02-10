# Tic Tac Toe
<image src="https://user-images.githubusercontent.com/11141077/217861492-7c20f4ee-c5c0-44b3-9746-7d9dfd0bf535.gif" width=300 />

This project is an RVB sample project that implements [TicTacToe](https://en.wikipedia.org/wiki/Tic-tac-toe) game.

You can see basic structure using RVB.

In this project, various frameworks such as [ReactorKit](https://github.com/ReactorKit/ReactorKit), [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources), and [SnapKit](https://github.com/SnapKit/SnapKit) are utilized for the implementation of the UI.

You can ignore detail of implementation of the UI.

And [Compose](https://github.com/wlsdms0122/Compose), [Route](https://github.com/wlsdms0122/Route) and [Deeplinker](https://github.com/wlsdms0122/Deeplinker) are framework that help to implement RVB concept.

## Features
- Basic `Router`, `Builder`, `View`(`Controllable`) structure and convention.
- `View` using different UI fraemworks. (using [Compose](https://github.com/wlsdms0122/Compose))
  - Most views are written using UIKit. But the `Scoreboard` view is written using SwiftUI.
- Inter-module communications.
  - Also inter-module adapting case in `Root`(Rx) <- `Scoreboard`(Combine).
- Pass module's `Dependency` & `Parameter` in `Builder`.
- Routing of modules. (using [Route](https://github.com/wlsdms0122/Route))
  - `Router` & route method in `View`.
- Deeplinking. (using [Deeplinker](https://github.com/wlsdms0122/Deeplinker))
  - tictactoe://game
  - tictactoe://scoreboard