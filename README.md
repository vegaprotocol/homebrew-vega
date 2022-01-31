# homebrew-vega

The Homebrew repository for Vega Protocol application.

## Set up the Tap

First, add the `vega` tap to your Homebrew.

```sh
brew tap vegaprotocol/vega
```

## Uploading built bottles

Wait until the pull request’s checks become green. Then label your pull request with the `publish` label (this is the default label that will trigger the uploading workflow; you can easily change this in workflow file). A new brew pr-pull workflow will be fired up and after a couple of minutes you should observe the PR closed, bottles uploaded and commits pushed to the main branch of your repository.

## Tips

### Update Formula's SHA-256

The Formula's SHA-256 should be computed on the **tagged** archive got through the Formula's URL.

###### MacOS

```sh
shasum -a 256 <my-archive>
```
