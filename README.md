# homebrew-vega

The Homebrew repository for Vega Protocol application.

## Set up the Tap

First, add the `vega` tap to your Homebrew.

```sh
brew tap vegaprotocol/vega
```

## Distribute new versions

### 1. Update the tag and revision

Each formula has a `url` property that points to the repository.

Its `tag` parameter should be valued with the tag we are targeting.

Its `revision` parameter should be valued with the commit hash the tag is associated with.

### 2. Open a pull request

Open a pull request and wait until the pull request checks become green.

A good name for the branch would be `release/<software>-<version>`.

##### Example

```
release/vega-0.71.4
```

##### Warning

**Do not merge the PR yourself.** The merge is handled by the GitHub actions. See the next step for more detail.

### 3. Trigger the release workflow

Once the checks are green, label your pull request with the `publish` label. This label triggers the bottles uploading (`brew pr-pull`) workflow.

After a couple of minutes, the pull request should be closed, the bottles uploaded and commits pushed to the main branch of your repository.

### Pro-tips

#### Linter

You can reformat the file using:
```
brew style --fix ./Formula/*.rb
```
