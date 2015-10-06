AtJsSnippetView = require './at-js-snippet-view'
{CompositeDisposable} = require 'atom'

module.exports = AtJsSnippet =
  atJsSnippetView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atJsSnippetView = new AtJsSnippetView(state.atJsSnippetViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atJsSnippetView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'at-js-snippet:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atJsSnippetView.destroy()

  serialize: ->
    atJsSnippetViewState: @atJsSnippetView.serialize()

  toggle: ->
    console.log 'AtJsSnippet was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
