module Main where

import Control.Monad.Eff.Console

import Prelude

import Data.Maybe
import Control.Monad.Eff
import Data.Maybe.Unsafe
import Data.Nullable (toMaybe)

import qualified Thermite as T
import qualified Thermite.Action as T

import qualified React as R
import qualified React.DOM as R
import qualified React.DOM.Props as RP
import qualified DOM as DOM
import qualified DOM.HTML as DOM
import qualified DOM.HTML.Document as DOM
import qualified DOM.HTML.Types as DOM
import qualified DOM.HTML.Window as DOM

render :: T.Render _ {} _ {}
render _ _ _ _ = R.div' [ R.h1' [ R.text "Hello world!" ] ]

spec :: T.Spec _ {} _ {}
spec = T.simpleSpec {} perfAction render

perfAction :: T.PerformAction _ {} _ {}
perfAction _ _ = T.modifyState (const {})

main :: forall eff. Eff (dom :: DOM.DOM | eff) R.ReactElement
main = body >>= R.render (R.createFactory (T.createClass spec) {})
    where
            body = do
                        win <- DOM.window 
                        doc <- DOM.document win
                        elm <- fromJust <$> toMaybe <$> DOM.body doc
                        return $ DOM.htmlElementToElement elm
