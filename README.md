# OTUS_RDB курсовой проект
## Постановка задачи

1. Интернет магазин (витрина) - иерархическая структура категорий товаров, товары, производители, поставщики, цены, характеристики товаров (у разных категорий товаров - разные характеристики). 

2*). расширяем магазин - клиенты, покупки (транзакции);

3*). интеграция магазина с платежными системами - платежные системы, транзакции с платежной системой, аккаунты, счета, транзакции магазина;

Описанные сущности не являются полным и конечным ТЗ (как это и бывает в жизни). Вы как архитектор должны предусмотреть необходимые атрибуты и дополнительные сущности по необходимости. И четко представлять бизнес-задачу которую будет решать эта структура данных.

##  Домашнее задание 1

Делаем декомпозицию и нормализацию. В качестве сделанной ДЗ принимается pdf с начальной и конечной моделью.

Решая данное ДЗ вы тренируете навык проектирования БД, выделения сущностей и их атрибутов, построения связей, нормализации данных

### Решение

В качестве модели была принята поставка единичного оборудования (например бытовой техники, запчастей, единиц оружия). Производство продукции не привязано к производителю, но каждый единичный товар имеет сериальный номер. 

![Image of Yaktocat](https://github.com/yaraleo/OTUS_RDB/blob/master/schema_v2.png)

Выбранные таблицы отношений:

| Таблица       | Назначение         |
| ------------- |------------------|
| vendors |производители оборудования|
| dealers |поставщики оборудования|
| dealers2vendors|связь дилеры - производители|
| model|модели оборудования|
| model2description|связь характеристик с моделями|
| description|характеристики с описаниями|
| stock|товары на складе|
| categories|категории товаров|
| product|карточка товара интернет магазина|
| orders|заказы|
| order2product|связь заказы - товары|
| payments|платежи|
| users|пользователи|


##  Домашнее задание 2

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
        </tr><tr><td>id_vendor</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор вендора (производителя)</td></tr><tr><td>vend_name</td><td>VARCHAR(45)</td><td>Yes</td><td>No</td><td>No</td><td></td><td>Название вендора</td></tr><tr><td>vend_address</td><td>VARCHAR(255)</td><td>Yes</td><td>No</td><td>No</td><td></td><td>Адрес вендора</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_vendor`']</td><td>PRIMARY</td><td></td></tr></table></br><table><caption>Index: id_vendor_UNIQUE</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_vendor_UNIQUE</td><td>['`id_vendor`']</td><td>UNIQUE</td><td></td></tr></table></br></table></br><table><caption>Table: categories - </caption><tr><td colspan="7">Attributes</td></tr>
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
        </tr><tr><td>id_product</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор таблицы продукт</td></tr><tr><td>id_categ</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентификатор категории</td></tr><tr><td>product_name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Имя продукта</td></tr><tr><td>id_model</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентификатор модели внешний ключ</td></tr><tr><td>price</td><td>DECIMAL(10,4)</td><td>No</td><td>No</td><td>No</td><td></td><td>Цена продажи</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_product`']</td><td>PRIMARY</td><td></td></tr></table></br><table><caption>Index: id_model_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_model_idx</td><td>['`id_model`']</td><td>INDEX</td><td></td></tr></table></br><table><caption>Index: id_categ_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_categ_idx</td><td>['`id_categ`']</td><td>INDEX</td><td></td></tr></table></br></table></br><table><caption>Table: dealers2vendors - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_dealer2vendor</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор связи Дилер - Производитель</td></tr><tr><td>id_dealer</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентификатор дилера</td></tr><tr><td>id_vendor</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентификатор производителя</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_dealer2vendor`']</td><td>PRIMARY</td><td>Индекс на ключевое поле.</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_dealer`']</td><td>INDEX</td><td>Индекс на внешний ключ</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_vendor`']</td><td>INDEX</td><td>Индекс на внешний ключ</td></tr></table></br></table></br><table><caption>Table: model - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_model</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор модели в таблице</td></tr><tr><td>model_name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Название модели</td></tr><tr><td>id_vendor</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентификатор производителя</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_model`']</td><td>PRIMARY</td><td></td></tr></table></br><table><caption>Index: id_vendor_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_vendor_idx</td><td>['`id_vendor`']</td><td>INDEX</td><td></td></tr></table></br></table></br><table><caption>Table: stock - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_items</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор записи в таблице</td></tr><tr><td>id_dealer2vendor</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Внешний ключ поставки</td></tr><tr><td>id_date</td><td>DATE</td><td>No</td><td>No</td><td>No</td><td></td><td>Статус единицы товара на складе</td></tr><tr><td>id_model</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Внешний ключ модель</td></tr><tr><td>item_serial_num</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Сериальный уникальный номер производителя единцы товара</td></tr><tr><td>item_cost</td><td>DECIMAL(10,4)</td><td>No</td><td>No</td><td>No</td><td></td><td>Закупочная цена поставщика</td></tr><tr><td>id_categ</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентфикатор категории - Внешний ключ</td></tr><tr><td>reserve_sold</td><td>ENUM("1", "2", "3")</td><td>No</td><td>No</td><td>No</td><td></td><td>Статус 1-резерв, 2- продано, 3 - неисправно</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_items`']</td><td>PRIMARY</td><td></td></tr></table></br><table><caption>Index: id_dealer2vendor_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_dealer2vendor_idx</td><td>['`id_dealer2vendor`']</td><td>INDEX</td><td></td></tr></table></br><table><caption>Index: id_model_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_model_idx</td><td>['`id_model`']</td><td>INDEX</td><td></td></tr></table></br><table><caption>Index: id_categ_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_categ_idx</td><td>['`id_categ`']</td><td>INDEX</td><td></td></tr></table></br></table></br><table><caption>Table: model2description - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_model2description</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор таблицы Описания</td></tr><tr><td>id_description</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Название набора описания</td></tr><tr><td>id_model</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентификатор модели</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_model2description`']</td><td>PRIMARY</td><td></td></tr></table></br><table><caption>Index: id_model_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_model_idx</td><td>['`id_model`']</td><td>INDEX</td><td></td></tr></table></br><table><caption>Index: id_description_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_description_idx</td><td>['`id_description`']</td><td>INDEX</td><td></td></tr></table></br></table></br><table><caption>Table: description - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_description</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор таблицы характеристик</td></tr><tr><td>description_name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Имя характеристики</td></tr><tr><td>description_vol</td><td>VARCHAR(255)</td><td>No</td><td>No</td><td>No</td><td></td><td>Значение или описание характеристики</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_description`']</td><td>PRIMARY</td><td></td></tr></table></br><table><caption>Index: id_description</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_description</td><td>['`id_description`']</td><td>INDEX</td><td></td></tr></table></br></table></br><table><caption>Table: users - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_user</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификация пользователя</td></tr><tr><td>name</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Имя пользователя</td></tr><tr><td>lastname</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Фамилия пользователя</td></tr><tr><td>birthdate</td><td>DATE</td><td>No</td><td>No</td><td>No</td><td></td><td>Дата рождения пользователя</td></tr><tr><td>login</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Внешний ключ связи логина и пароля пользователя</td></tr><tr><td>hash_pass</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td></td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_user`']</td><td>PRIMARY</td><td>Индекс на ключевое поле</td></tr></table></br></table></br><table><caption>Table: orders - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_order</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор записи о заказе</td></tr><tr><td>order_number</td><td>VARCHAR(45)</td><td>No</td><td>No</td><td>No</td><td></td><td>Номер заказа в учетной системе компании</td></tr><tr><td>date</td><td>DATE</td><td>No</td><td>No</td><td>No</td><td></td><td>Дата заказа</td></tr><tr><td>id_user</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентификатор пользователя заказа</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_order`']</td><td>PRIMARY</td><td>Индекс на ключевое поле</td></tr></table></br><table><caption>Index: order_user_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>order_user_idx</td><td>['`id_user`']</td><td>INDEX</td><td>Индекс по ключевому полю</td></tr></table></br></table></br><table><caption>Table: order2product - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_order2product</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор пункта заказа</td></tr><tr><td>id_order</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Внешний ключ - Идентификатор заказа</td></tr><tr><td>id_product</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентификатор продукта</td></tr><tr><td>qty</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td>Количество единиц продукта</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_order2product`']</td><td>PRIMARY</td><td></td></tr></table></br><table><caption>Index: id_product_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_product_idx</td><td>['`id_product`']</td><td>INDEX</td><td></td></tr></table></br><table><caption>Index: id_order_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_order_idx</td><td>['`id_order`']</td><td>INDEX</td><td></td></tr></table></br></table></br><table><caption>Table: payments - </caption><tr><td colspan="7">Attributes</td></tr>
        <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Not Null</th>
        <th>PK</th>
        <th>FK</th>
        <th>Default</th>
        <th>Comment</th>
        </tr><tr><td>id_payments</td><td>INT</td><td>Yes</td><td>Yes</td><td>No</td><td></td><td>Идентификатор строки платежа</td></tr><tr><td>transaction_id</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td>Идентификатор транзакции в платежной системе</td></tr><tr><td>datetime</td><td>DATETIME</td><td>No</td><td>No</td><td>No</td><td></td><td>Дата время транзакции</td></tr><tr><td>id_order</td><td>INT</td><td>No</td><td>No</td><td>Yes</td><td></td><td>Идентификатор заказа</td></tr><tr><td>sum</td><td>INT</td><td>No</td><td>No</td><td>No</td><td></td><td>Сумма платежа</td></tr><tr><td>currency</td><td>VARCHAR(5)</td><td>No</td><td>No</td><td>No</td><td></td><td>Валюта платежа</td></tr></table></br><table><caption>Index: PRIMARY</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>PRIMARY</td><td>['`id_payments`']</td><td>PRIMARY</td><td></td></tr></table></br><table><caption>Index: id_order_idx</caption><tr><td colspan="4">Attributes</td></tr>
                <tr>
                <th>Name</th>
                <th>Columns</th>
                <th>Type</th>
                <th>Description</th>
                </tr>
                <tr><td>id_order_idx</td><td>['`id_order`']</td><td>INDEX</td><td></td></tr></table></br></table></br>
                
##  Домашнее задание 3

*Описываем логику транзакций для своей модели данных
В вашем проекте базы данных опишите
транзакцию, которая будет включать в себя несколько действий
и исключать возможность взаимных блокировок и неоднозначных ситуаций*

Описание должно включать в себя
- бизнес задачу
- вероятные проблемы
- SQL транзакции или возможно нескольких транзакций

### Решение

Бизнес-задача 1. Проверка пользователя при регистрации; 

START TRANSACTION;
UPDATE user_account SET allsum=allsum + 1000 WHERE id='1';
UPDATE user_account SET allsum=allsum - 1000 WHERE id='2';
COMMIT;

Бизнес-задача 2. Авторизация на сайте электронного магазина; 

Бизнес-задача 3. Проверка статуса наличия товара на складе при заказе товара. 

Бизнес-задача 4. Проверка статуса оплаты заказа. 

Бизнес-задача 5. Проверка цены продажи и закупочной цены. 

Бизнес-задача 6. Доставка/пополнение склада. 

Бизнес-задача 7. Завершение выпуска какой-либо модели. 




## Домашнее задание 4

*Добавляем в модель данных дополнительные индексы и ограничения*

*1. Проводим анализ возможных запросов\отчетов\поиска данных.*

*2. Предполагаем возможную кардинальность поля.*

*3. Создаем дополнительные индексы - простые или композитные.* 

*4. На каждый индекс пишем краткое описание зачем он нужен (почему по этому полю\полям).*

*5. Думаем какие логические ограничения в БД нужно добавить - например какие поля должны быть уникальны, в какие нужно добавить условия, чтобы не нарушить бизнес логику. Пример - нельзя провести операцию по переводу средств на отрицательную сумму.* 

*6. Создаем ограничения по выбранным полям.*

### Решение


## Домашнее задание 4

*Доработка проекта*

*С учетом всех пройденных занятий доработать свой проект до финального представления*

*В проекте должны быть:*

*- схема*

*- документация*

*- примеры бизнес-задач которые решает база*

*- рекомендации к использованию репликации*

*- рекомендации к резервному копированию*


### Решение

