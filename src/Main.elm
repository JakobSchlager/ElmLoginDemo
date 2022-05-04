module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (..)
import Http exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

-- MAIN


main =
  Browser.element 
   { init = init
   , update = update
   , subscriptions = subscriptions
   , view = view
   }


-- MODEL
type alias Model = {
    username: String, 
    password: String, 
    loginStatus: String
  }


init : () -> (Model, Cmd Msg)
init _ = 
  ( { 
    username = "hansi", 
    password = "password",
    loginStatus = "fill in form!"
    }
  , Cmd.none
  )



-- UPDATE
type Msg
  = ChangeUsername String
  | ChangePassword String
  | Login
  | LoggedIn (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ChangeUsername newUsername ->
      ({ model | username = newUsername }, Cmd.none)
    ChangePassword newPassword -> 
      ({ model | password = newPassword }, Cmd.none)
    Login -> 
      (
      { model | loginStatus = "Sent Login" }
      , Http.get { url = "https://elm-lang.org/assets/public-opinion.txt"
      , expect = Http.expectString LoggedIn
      })
    LoggedIn result -> 
      case result of 
        Ok text -> 
          ({ model | loginStatus = text }, Cmd.none)
        Err _ -> 
          ({ model | loginStatus = "Login Failed" }, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = 
  Sub.none


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
