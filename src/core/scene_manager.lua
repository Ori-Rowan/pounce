SceneManager = {
    current_scene=nil
}

function SceneManager:update()
    if (self.current_scene == nil) return log("No current scene", "Warning")

    self.current_scene:update()
end

function SceneManager:draw()
    if (self.current_scene == nil) return log("No current scene", "Warning")

    self.current_scene:draw()
end

function SceneManager:enter_scene(scene)
    self.current_scene = scene:new({scene_manager=self})
    self.current_scene:enter()
end