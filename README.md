
## Requirements

This project was created using the following environment:

* Xcode 11.5

* macOS 10.15.5 (19F101)

## Before you start, configure the project

To configure the project, perform the following steps in Xcode:

1. On the Signing & Capabilities pane, [set the bundle ID][3] to a unique identifier (you must change the bundle ID to proceed).
2. [Add your Apple ID account][4] and [assign the target to a team][5] so Xcode can later create a provisioning profile.
3. Choose a run destination from the scheme pop-up menu.
4. If necessary, click Register Device in the Signing & Capabilities pane to create the provisioning profile.
5. In the toolbar, click Run, or choose Product > Run (⌘R). 


## Implementation notes

The app uses [SwiftUI][6] to deliver a game-like interface allowing users to play tik tak toe.

The game logic, layout and accessibility aspects of the app are tested using the [XCTest][2] framework.

* [Screen layout](x-source-tag://root_layout)

* [Unit tests](x-source-tag://unit_tests)

* [UI tests](x-source-tag://ui_tests)

## Tik Tak Toe Rules

The [rules of the game][1] are as follows:

- X always goes first.
- Players cannot play on a played position.
- Players alternate placing X’s and O’s on the board until either:
	- One player has three in a row, horizontally, vertically or diagonally
	- All nine squares are filled.
- If a player is able to draw three X’s or three O’s in a row, that player wins.
- If all nine squares are filled and neither player has three in a row, the game is a draw.





[1]:https://github.com/stephane-genicot/katas/blob/master/TicTacToe.md
[2]:https://developer.apple.com/documentation/xctest
[3]:https://help.apple.com/xcode/mac/current/#/deve21d0239c
[4]:https://help.apple.com/xcode/mac/current/#/devaf282080a
[5]:https://help.apple.com/xcode/mac/current/#/dev23aab79b4
[6]:https://developer.apple.com/xcode/swiftui/

