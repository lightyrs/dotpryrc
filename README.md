# dotpryrc for you and me!

My customized fork of [original dotpryrc](https://github.com/JuanitoFatas/dotpryrc).

I want my tools to just work, right now, out of the box, without a pain.
I want to be able to debug as quickly as possible.
And also i want syntax highlighting & code formatting in Pry session.

## What is [Pry](https://github.com/pry/pry/)?

> An IRB alternative and runtime developer console.

## What is .pryrc?

Pry startup file, more information [The .pryrc file](https://github.com/pry/pry/wiki/Pry-rc).

## What's inside?

* A security check for your old Ruby.
* Better printing via [hirb](https://github.com/cldwalker/hirb) and [awesome_print](http://github.com/michaeldv/awesome_print).
* Four convenient hotkeys when travelling in debugging.
* Customized hotkeys for Ruby and Pry built-in commands.
* Copy-to-clipboard utility for OSX or one-command install away for non OSX.
* Added helpers: `lorem` Ipsum, `to_yaml` abstraction, `Array#toy`, `Hash#toy`...etc.
* Save Pry's history to `.irb_history` for Environment protection.

## Installation

Clone this repo somewhere (e.g. ~/.dotpryrc) and
`require 'dotpryrc/bootstrap'` in your ~/.pryrc,
than install missing gems & you're set.

## Usage

If you're using ruby 2 + [byebug](https://github.com/deivid-rodriguez/byebug) + [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug), there are [some](https://github.com/vyorkin/dotpryrc/blob/master/config/hotkeys.rb)
[aliases available](https://github.com/vyorkin/dotpryrc/blob/master/config/aliases.rb) for you.


## 

Fork & customize it for your personal needs (as i did).
