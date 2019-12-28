module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)



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
    { articles : List Article
    , input : Article
    }


init : Model
init =
    { articles = []
    , input = Article "" ""
    }


type Msg
    = Add
    | ChangeTitle String
    | ChangeBody String



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            { model | articles = Article model.input.title model.input.body :: model.articles }

        ChangeTitle newTitle ->
            { model | input = Article newTitle model.input.body }

        ChangeBody newBody ->
            { model | input = Article model.input.title newBody }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewTable model.articles
        , viewInput model
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


viewInput : Model -> Html Msg
viewInput model =
    div []
        [ div []
            [ text "Title"
            , input [ placeholder "Title", value model.input.title, onInput ChangeTitle ] []
            ]
        , div []
            [ text "Body"
            , input [ placeholder "Body", value model.input.body, onInput ChangeBody ] []
            ]
        ]
