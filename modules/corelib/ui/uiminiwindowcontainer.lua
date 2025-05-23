-- @docclass
UIMiniWindowContainer = extends(UIWidget, "UIMiniWindowContainer")

function UIMiniWindowContainer.create()
  local container = UIMiniWindowContainer.internalCreate()
  container.scheduledWidgets = {}
  container:setFocusable(false)
  container:setPhantom(true)
  container:setVisible(false)
  container:setHeight(0)
  return container
end

-- TODO: connect to window onResize event
-- TODO: try to resize another widget?
-- TODO: try to find another panel?
function UIMiniWindowContainer:fitAll(noRemoveChild)
  if not self:isVisible() then
    return
  end

  if not noRemoveChild then
    local children = self:getChildren()
    if #children > 0 then
      noRemoveChild = children[#children]
    else
      return
    end
  end

  local sumHeight = 0
  local children = self:getChildren()
  for i=1,#children do
    if children[i]:isVisible() then
      sumHeight = sumHeight + children[i]:getHeight()
    end
  end

  local selfHeight = self:getHeight() - (self:getPaddingTop() + self:getPaddingBottom())
  if sumHeight <= selfHeight then
    return
  end

  local removeChildren = {}

  -- try to resize noRemoveChild
  local maximumHeight = selfHeight - (sumHeight - noRemoveChild:getHeight())
  if noRemoveChild:isResizeable() and noRemoveChild:getMinimumHeight() <= maximumHeight then
    sumHeight = sumHeight - noRemoveChild:getHeight() + maximumHeight
    addEvent(function() noRemoveChild:setHeight(maximumHeight) end)
  end

  -- try to remove no-save widget
  for i=#children,1,-1 do
    if sumHeight <= selfHeight then
      break
    end

    local child = children[i]
    if child ~= noRemoveChild and not child.save then
      local childHeight = child:getHeight()
      sumHeight = sumHeight - childHeight
      table.insert(removeChildren, child)
    end
  end

  -- try to remove save widget, not forceOpen
  for i=#children,1,-1 do
    if sumHeight <= selfHeight then
      break
    end

    local child = children[i]
    if child ~= noRemoveChild and child:isVisible() and not child.forceOpen then
      local childHeight = child:getHeight()
      sumHeight = sumHeight - childHeight
      table.insert(removeChildren, child)
    end
  end

  -- try to remove save widget
  for i=#children,1,-1 do
    if sumHeight <= selfHeight then
      break
    end

    local child = children[i]
    if child ~= noRemoveChild and child:isVisible() then
      local childHeight = child:getHeight() - 50
      sumHeight = sumHeight - childHeight
      table.insert(removeChildren, child)
    end
  end

  -- close widgets
  for i=1,#removeChildren do
    if removeChildren[i].forceOpen then
      removeChildren[i]:minimize(true)
    else
      removeChildren[i]:close()
    end
  end
end

function UIMiniWindowContainer:onDrop(widget, mousePos)
  if widget.UIMiniWindowContainer then
    local oldParent = widget:getParent()
    if oldParent == self then
      return true
    end

    if oldParent then
      oldParent:removeChild(widget)
    end

    if widget.movedWidget then
      local index = self:getChildIndex(widget.movedWidget)
      self:insertChild(index + widget.movedIndex, widget)
    else
      self:addChild(widget)
    end

    self:fitAll(widget)
    return true
  end
end

function UIMiniWindowContainer:moveTo(newPanel)
  if not newPanel or newPanel == self then
    return
  end
  local children = self:getChildByIndex(1)
  while children do
    newPanel:addChild(children)
    children = self:getChildByIndex(1)
  end
  newPanel:fitAll()
end

function UIMiniWindowContainer:swapInsert(widget, index)
  local oldParent = widget:getParent()
  local oldIndex = self:getChildIndex(widget)

  if oldParent == self and oldIndex ~= index then
    local oldWidget = self:getChildByIndex(index)
    if oldWidget then
      self:removeChild(oldWidget)
      self:insertChild(oldIndex, oldWidget)
    end
    self:removeChild(widget)
    self:insertChild(index, widget)
  end
end

function UIMiniWindowContainer:scheduleInsert(widget, index)
  if index - 1 > self:getChildCount() then
    if self.scheduledWidgets[index] then
      pdebug('replacing scheduled widget id ' .. widget:getId())
    end
    self.scheduledWidgets[index] = widget
  else
    local oldParent = widget:getParent()
    if oldParent ~= self then
      if oldParent then
        oldParent:removeChild(widget)
      end
      self:insertChild(index, widget)

      while true do
        local placed = false
        for nIndex,nWidget in pairs(self.scheduledWidgets) do
          if nIndex - 1 <= self:getChildCount() then
            local oldParent = nWidget:getParent()
            if oldParent ~= self then
              if oldParent then
                oldParent:removeChild(nWidget)
              end
              self:insertChild(nIndex, nWidget)
            else
              self:moveChildToIndex(nWidget, nIndex)
            end
            self.scheduledWidgets[nIndex] = nil
            placed = true
            break
          end
        end
        if not placed then break end
      end
    end
  end
end

function UIMiniWindowContainer:order()
  local children = self:getChildren()
  for i=1,#children do
    if not children[i].miniLoaded then return end
  end

  table.sort(children, function(a, b)
    local indexA = a.miniIndex or a.autoOpen or 999
    local indexB = b.miniIndex or b.autoOpen or 999
    return indexA < indexB
  end)

  self:reorderChildren(children)
  local ignoreIndex = 0
  for i=1,#children do
    if children[i].save then
      children[i].miniIndex = i - ignoreIndex
    else
      ignoreIndex = ignoreIndex + 1
    end      
  end
end

function UIMiniWindowContainer:saveChildren()
  local children = self:getChildren()
  local ignoreIndex = 0
  for i=1,#children do
    if children[i].save then
      children[i]:saveParentIndex(self:getId(), i - ignoreIndex)
    else
      ignoreIndex = ignoreIndex + 1
    end
  end
end

function UIMiniWindowContainer:onGeometryChange()
  self:fitAll()
end