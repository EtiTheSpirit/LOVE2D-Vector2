# Vector2
Vector2 libraries for the LOVE2D game engine.

This was written by Brent "XanthicDragon"/"Xan" D.

This is open source, all yours if you want. Mod it, do whatever, I don't care. If you are a nice person, you can credit me. Your choice entirely.

# Using Vector2
Vector2s are created with a simple command:

`local point = Vector2.new(x, y)`


# Operations:
Vector2s support basic operations: + - / *

Example: Vector2.new(1, 1) * Vector2.new(2, 2)


# Properties
`a = Vector2.new(1, 1)`

a.Magnitude - Gets the magnitude of this vector.

a.Unit - Gets the direction of this vector.

a.x OR a.X or a[1] - Gets the x value of this vector

a.y OR a.Y or a[2] - Gets the Y value of this vector


# Methods
`a = Vector2.new(1, 1); b = Vector2.new(2, 2)`

a:toAngle(b) - Gets the angle between a and b

a:lerp(b, f) - Moves between a and b by *f*, where f is a number between 0 or 1 (or at 0 or 1)
