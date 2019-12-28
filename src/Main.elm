module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Article =
    { title : String
    , body : String
    }


type alias Model =
    { articles : List Article }


init : Model
init =
    { articles = [] }


type Msg
    = Add



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            { model | articles = Article "タイトル" "本文" :: model.articles }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewTable model.articles
        , button [ onClick Add ] [ text "Add" ]
        ]


viewTable : List Article -> Html Msg
viewTable articles =
    table []
        [ thead []
            [ th [] [ text "Title" ]
            , th [] [ text "Body" ]
            ]
        , tbody [] (List.map viewTr articles)
        ]


viewTr : Article -> Html Msg
viewTr article =
    tr []
        [ td [] [ text article.title ]
        , td [] [ text article.body ]
        ]
