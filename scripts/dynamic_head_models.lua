---@class DynamicHeadModels プレイヤーの頭及びポートレートモデルの管理を行うクラス
DynamicHeadModels = {
	---初期化関数
	init = function ()
        ---プレイヤーの頭及びポートレートモデルを生成する。
        ---@param root ModelPart 頭モデルのルートとなるモデルパーツ
        local function generateDynamicHeadModels(root)
            ---モデルパーツをディープコピーする。非表示のモデルパーツはコピーしない。
            ---@param modelPart ModelPart コピーするモデルパーツ
            ---@return ModelPart? copiedModelPart コピーされたモデルパーツ。入力されたモデルパーツが非表示の場合はnilが返る。
            local function copyModel(modelPart)
                if modelPart:getVisible() then
                    local copy = modelPart:copy(modelPart:getName())
                    copy:setParentType("None")
                    copy:setVisible(true)
                    for _, child in ipairs(copy:getChildren()) do
                        copy:removeChild(child)
                        local childModel = copyModel(child)
                        if childModel ~= nil then
                            copy:addChild(childModel)
                        end
                    end
                    return copy
                end
            end

            local copiedPart = copyModel(models.models.main.Avatar.Head)
            if copiedPart ~= nil then
                root:addChild(copiedPart)
                if root["Head"]["ArmorH"] ~= nil then
                    root["Head"]["ArmorH"]:remove()
                end
            end
        end

        ---モデルの生成先の準備
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_head_block", "Skull")
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_portrait", "Portrait")

        ---頭モデルの生成
        for _, modelPart in ipairs({models.script_head_block, models.script_portrait}) do
            modelPart:setPos(0, -24, 0)
            generateDynamicHeadModels(modelPart)
        end
	end
}

DynamicHeadModels.init()

return DynamicHeadModels