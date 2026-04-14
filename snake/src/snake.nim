import sdl2
import random

const
  SCREEN_WIDTH = 800
  SCREEN_HEIGHT = 600
  TILE_SIZE : cint = 20
  FPS = 60

var
  running = true
  snake = @[ (x: 10, y: 10) ]
  direction = (x: 1, y: 0)
  nextDirection = (x: 1, y: 0)
  apple = (x: 15, y: 15)
  SNAKE_COLOR : Color = (r: 0, g: 255, b: 0, a: 255)
  APPLE_COLOR : Color = (r: 255, g: 0, b: 0, a: 255)

type SDLException = object of Exception

type
  Input {.pure.} = enum none, left, right, up, down, quit

  Game = ref object
    inputs: array[Input, bool]
    renderer: RendererPtr

template sdlFailIf(cond: typed, reason: string) =
  if cond: raise SDLException.newException(
    reason & ", SDL error: " & $getError())

proc newGame(renderer: RendererPtr): Game =
  new result
  result.renderer = renderer

proc handleInput(game: Game) =
  var event = defaultEvent
  while pollEvent(event):
    case event.kind:
    of sdl2.EventType.QuitEvent:
      running = false
    of sdl2.EventType.KeyDown:
      case event.key.keysym.scancode:
      of SDL_SCANCODE_Q:
        running = false
      of SDL_SCANCODE_A:
        if direction.x != 1: nextDirection = (x: -1, y: 0)
      of SDL_SCANCODE_D:
        if direction.x != -1: nextDirection = (x: 1, y: 0)
      of SDL_SCANCODE_W:
        if direction.y != 1: nextDirection = (x: 0, y: -1)
      of SDL_SCANCODE_S:
        if direction.y != -1: nextDirection = (x: 0, y: 1)
      else:
        discard
    else:
      discard

    direction = nextDirection

    # Update
    let newHead = (x: snake[0].x + direction.x, y: snake[0].y + direction.y)

    # Collision Check (Wall)
    if newHead.x < 0 or newHead.x * TILE_SIZE >= SCREEN_WIDTH or
       newHead.y < 0 or newHead.y * TILE_SIZE >= SCREEN_HEIGHT:
       running = false

    # Collision Check (Self)
    for segment in snake:
      if segment == newHead:
        running = false

    snake.insert(newHead, 0)

    # Eat Apple
    if newHead.x == apple.x and newHead.y == apple.y:
      while true:
        apple = (x: rand(SCREEN_WIDTH div TILE_SIZE), y: rand(SCREEN_HEIGHT div TILE_SIZE))
        var onSnake = false
        for segment in snake:
          if segment == apple:
            onSnake = true
        if not onSnake: break
    else:
      snake.delete(snake.len() - 1)

proc render(game: Game) =
  # Draw over all drawings of the last frame with the default color
  game.renderer.clear()

  game.renderer.setDrawColor(SNAKE_COLOR)
  for segment in snake:
    var rect : Rect = (x: cint(segment.x * TILE_SIZE), y: cint(segment.y * TILE_SIZE), w: TILE_SIZE, h: TILE_SIZE)
    game.renderer.fillRect(rect)

  game.renderer.setDrawColor(APPLE_COLOR)
  var rect : Rect = (x: cint(apple.x * TILE_SIZE), y: cint(apple.y * TILE_SIZE), w: TILE_SIZE, h: TILE_SIZE)
  game.renderer.fillRect(rect)

  # Show the result on screen
  game.renderer.present()

proc main() =
  sdlFailIf(not sdl2.init(INIT_VIDEO or INIT_TIMER or INIT_EVENTS)):
    "SDL2 initialization failed"

  defer: sdl2.quit()

  sdlFailIf(not setHint("SDL_RENDER_SCALE_QUALITY", "2")):
    "Linear texture filtering could not be enabled"

  let window = createWindow(title = "Snake Game",
    x = SDL_WINDOWPOS_CENTERED, y = SDL_WINDOWPOS_CENTERED,
    w = SCREEN_WIDTH, h = SCREEN_HEIGHT, flags = SDL_WINDOW_SHOWN)
  sdlFailIf window.isNil: "Window could not be created"
  defer: window.destroy()

  let renderer = window.createRenderer(index = -1,
    flags = Renderer_Accelerated or Renderer_PresentVsync)
  sdlFailIf renderer.isNil: "Renderer could not be created"
  defer: renderer.destroy()

  var game = newGame(renderer)

  # Game loop, draws each frame
  while running:
    game.handleInput()
    game.render()
    sdl2.delay(1000 div FPS)

  quit(0)

main()
