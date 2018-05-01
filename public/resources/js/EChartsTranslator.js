/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

function EChartsTranslator(lang, option) {
    switch (lang) {
        case 'az' :
            option.toolbox.feature.mark.title = {
                mark      : 'markLine',
                markUndo  : 'undo',
                markClear : 'clear'
            };
            option.toolbox.feature.dataZoom.title = {
                dataZoom      : 'Zoom',
                dataZoomReset : 'Reset'
            };
            option.toolbox.feature.dataView.title = 'Data View';
            option.toolbox.feature.dataView.lang  = ['Data View', 'close', 'refresh'];
            option.toolbox.feature.magicType.title = {
                line  : 'Line',
                bar   : 'Bar',
                stack : 'Stack',
                tiled : 'Tiled',
                force : 'Force',
                chord : 'Chord',
                pie   : 'Pie',
                funnel: 'Funnel'
            };
            option.toolbox.feature.restore.title = 'Restore';
            option.toolbox.feature.saveAsImage.title = 'Save Image';
            option.toolbox.feature.saveAsImage.lang = ['click Save'];
            break;

        case 'ru' :
            option.toolbox.feature.mark.title = {
                mark      : 'Нарисовать линию',
                markUndo  : 'Отменить',
                markClear : 'Очистить'
            };
            option.toolbox.feature.dataZoom.title = {
                dataZoom      : 'Увеличить',
                dataZoomReset : 'Сбросить'
            };
            option.toolbox.feature.dataView.title = 'Просмотр данных';
            option.toolbox.feature.dataView.lang  = ['Просмотр данных', 'Закрыть', 'Обновить'];
            option.toolbox.feature.magicType.title = {
                line  : 'Линейный график',
                bar   : 'Гистрограмма',
                stack : 'С накоплением',
                tiled : 'Без накопления',
                force : 'Топология',
                chord : 'Хордовый график',
                pie   : 'Круговая диаграмма',
                funnel: 'Воронкообразная диаграмма'
            };
            option.toolbox.feature.restore.title = 'Восстановить';
            option.toolbox.feature.saveAsImage.title = 'Сохранить картинку';
            option.toolbox.feature.saveAsImage.lang = ['нажмите чтобы сохранить'];
            break;

        case 'en' :
        default :
            option.toolbox.feature.mark.title = {
                mark      : 'markLine',
                markUndo  : 'Undo',
                markClear : 'Clear'
            };
            option.toolbox.feature.dataZoom.title = {
                dataZoom      : 'Zoom',
                dataZoomReset : 'Reset'
            };
            option.toolbox.feature.dataView.title = 'Data View';
            option.toolbox.feature.dataView.lang  = ['Data View', 'close', 'refresh'];
            option.toolbox.feature.magicType.title = {
                line  : 'Line',
                bar   : 'Bar',
                stack : 'Stack',
                tiled : 'Tiled',
                force : 'Force-directed',
                chord : 'Chord',
                pie   : 'Pie',
                funnel: 'Funnel'
            };
            option.toolbox.feature.restore.title = 'Restore';
            option.toolbox.feature.saveAsImage.title = 'Save Image';
            option.toolbox.feature.saveAsImage.lang = ['click to save'];
            break;
    }
    
    return option;
}