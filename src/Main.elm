module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model = {
    username: String, 
    password: String, 
    loginStatus: String
  }


init : Model
init = { 
    username = "hansi", 
    password = "password",
    loginStatus = "fill in form!"
  }



-- UPDATE


type Msg
  = ChangeUsername String
  | ChangePassword String
  | Login


update : Msg -> Model -> Model
update msg model =
  case msg of
    ChangeUsername newUsername ->
      { model | username = newUsername }
    ChangePassword newPassword -> 
      { model | password = newPassword }
    Login -> 
      { model | loginStatus = "success" }



-- VIEW


view : Model -> Html Msg
view model =
  div [] 
  [
    input [ placeholder "enter username", value model.username, onInput ChangeUsername  ] []
    , div [] [ text model.username ] 
    , input [ placeholder "enter password", value model.password, onInput ChangePassword  ] []
    , div [] [ text model.password ]
    , button [ onClick Login ] [ text model.loginStatus ] 
  ]
