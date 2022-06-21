class AppController < ApplicationController
  include UssdEngine::Controller
  include UssdEngine::Simulator

  def index(input)
    case input
    when nil
      prompt "Hello World! Enter 2 to go to screen 2."
    when 2, "2"
      display :next
    else
      prompt "Selection not recognized. Enter 2 to go to screen 2."
    end
  end

  def next(input)
    options = {
      index: "Home",
      finish: "Finish",
    }
    return prompt("You made it here. Where next?", options) unless input.present?

    option = resolve_option input, options
    return prompt("You seem lost. Try again.", options) unless option.present?

    display option
  end

  def finish(input)
    terminate "Goodbye"
  end
end
