# OTUS_RDB курсовой проект
## Постановка задачи

1. Интернет магазин (витрина) - иерархическая структура категорий товаров, товары, производители, поставщики, цены, характеристики товаров (у разных категорий товаров - разные характеристики). 

2*). расширяем магазин - клиенты, покупки (транзакции);

3*). интеграция магазина с платежными системами - платежные системы, транзакции с платежной системой, аккаунты, счета, транзакции магазина;

Описанные сущности не являются полным и конечным ТЗ (как это и бывает в жизни). Вы как архитектор должны предусмотреть необходимые атрибуты и дополнительные сущности по необходимости. И четко представлять бизнес-задачу которую будет решать эта структура данных.

##  Домашняя работа 1

Делаем декомпозицию и нормализацию. В качестве сделанной ДЗ принимается pdf с начальной и конечной моделью.

Решая данное ДЗ вы тренируете навык проектирования БД, выделения сущностей и их атрибутов, построения связей, нормализации данных

### Решение

В качестве модели была принята поставка единичного оборудования (например бытовой техники, запчастей, единиц оружия). Призводиство моделей не привязано к производителю, но каждый единичный товар имеет сериальный номер. 

Выбранные таблицы отношений:

| Таблица       | Назначение         |
| ------------- |------------------|
| vendors        |производители оборудования|
| dealers    |поставщики оборудования|
| dealers2vendors|связь дилеры - производители|
| model|модели оборудования|
| descriptions|наборы описаний моделей|
| characteristics|отдельные характеристики с описаниями моделей|
| shipments|таблица связь дилеры поставщики|
| items|единичные товары на складе|
| price|цены на товары|
| goods|карточка товара интернет магазина|
| categories|категории товаров|

##  Домашняя работа 2

*Корректируем типы данных в модели при необходимости
Взять свою структуру данных из ДЗ-1
и прописать комментарии на каждое поле с пояснением почему выбран данный тип поля и на сколько он удовлетворяет поставленной задаче*

### Решение

<table><caption>Table: vendors - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_vendor</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентафикатор вендора (производителя)</td></tr><tr><td>vend_name</td><td>VARCHAR(45)</td><td>Yes</td><td>No</td><td>No</td><td></td><td>Название вендора</td></tr><tr><td>vend_address</td><td>VARCHAR(255)</td><td>Yes</td><td>No</td><td>No</td><td></td><td>Адрес вендора</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_vendor`']</td><td>PRIMARY</td><td></td></tr></table></br></table></br><table><caption>Table: categories - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_categ</td><td>INT</td><td>Yes</td><td>Yes</td><td>Yes</td><td></td><td>Идентификатор категории товара, первичный ключ. Тип INT самый подходящий.</td></tr><tr><td>name_categ</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Имя категории. Взят универсальный формат для текста. Длина произвольная.</td></tr><tr><td>perent_id_categ</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Внешний ключ ссылается на какое-либо занчение из этой же таблицы, которое является родительским в иерархии категорий.</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_categ`']</td><td>PRIMARY</td><td></td></tr></table></br><table><caption>Index: parent_id_categ_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>parent_id_categ_idx</td><td>['`id_categ`', '`perent_id_categ`']</td><td>INDEX</td><td></td></tr></table></br></table></br><table><caption>Table: dealers - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_dealer</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор дилера</td></tr><tr><td>dealer_name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Имя дилера</td></tr><tr><td>dealer_adress</td><td>VARCHAR(255)</td><td>No</td><td>No</td><td>No</td><td></td><td>Адрес дилера</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_dealer`']</td><td>PRIMARY</td><td></td></tr></table></br></table></br><table><caption>Table: product - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_product</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td></td></tr><tr><td>id_categ</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>prdct_name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>prdct_producer_name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>id_model</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_product`']</td><td>PRIMARY</td><td></td></tr></table></br></table></br><table><caption>Table: dealers2vendors - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_dealership</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор связи Дилера - Производителя</td></tr><tr><td>id_dealer</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td>Идентификатор дилера</td></tr><tr><td>id_vendor</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td>Идентификатор производителя</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_dealership`']</td><td>PRIMARY</td><td></td></tr></table></br></table></br><table><caption>Table: model - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_model</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор модели в таблице</td></tr><tr><td>model_name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Название модели</td></tr><tr><td>id_vendor</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td>Идентификатор производителя</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_model`']</td><td>PRIMARY</td><td></td></tr></table></br></table></br><table><caption>Table: shipments - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_shipment</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td></td></tr><tr><td>date</td><td>DATE</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>id_dealership</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>qty</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_shipment`']</td><td>PRIMARY</td><td></td></tr></table></br></table></br><table><caption>Table: items - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_items</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td></td></tr><tr><td>id_shipment</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>id_model</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>item_serial_num</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>item_cost</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>item_sold_reserved_instock</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>item_price</td><td>DECIMAL</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr><tr><td>item_price_discount</td><td>DECIMAL</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_items`']</td><td>PRIMARY</td><td></td></tr></table></br></table></br><table><caption>Table: descriptions - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_descriptions</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор таблицы Описания</td></tr><tr><td>description_set_name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Название набора описания</td></tr><tr><td>id_model</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td>Идентификатор модели</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_descriptions`']</td><td>PRIMARY</td><td></td></tr></table></br></table></br><table><caption>Table: characteristics - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_characteristics</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор таблицы характеристик</td></tr><tr><td>characteristics_name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Имя характеристики</td></tr><tr><td>item_descriptions_vol</td><td>VARCHAR(255)</td><td>No</td><td>No</td><td>No</td><td></td><td>Значение или описание характеристики</td></tr><tr><td>id_description_set</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td>Идентификатор названия набора характеристик</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_characteristics`']</td><td>PRIMARY</td><td></td></tr></table></br></table></br>
</body></html>


##  Домашняя работа 3

*Описываем логику транзакций для своей модели данных
В вашем проекте базы данных опишите
транзакцию, которая будет включать в себя несколько действий
и исключать возможность взаимных блокировок и неоднозначных ситуаций*

Описание должно включать в себя
- бизнес задачу
- вероятные проблемы
- SQL транзакции или возможно нескольких транзакций

### Решение


## Домашняя работа 4

*Добавляем в модель данных дополнительные индексы и ограничения*

*1. Проводим анализ возможных запросов\отчетов\поиска данных.*

*2. Предполагаем возможную кардинальность поля.*

*3. Создаем дополнительные индексы - простые или композитные.* 

*4. На каждый индекс пишем краткое описание зачем он нужен (почему по этому полю\полям).*

*5. Думаем какие логические ограничения в БД нужно добавить - например какие поля должны быть уникальны, в какие нужно добавить условия, чтобы не нарушить бизнес логику. Пример - нельзя провести операцию по переводу средств на отрицательную сумму.* 

*6. Создаем ограничения по выбранным полям.*

### Решение

