#encoding: utf-8
class CreateAccounts < ActiveRecord::Migration
  MORE_ACCOUNTS = [
    {:name => 'Лукомир', :account => '111666', :pass => '3366', :sum => 12000, :credit => 0, :creditsum => 0, :mail => 'vasyaabr@gmail.com', :active => 1, :admin => 1},
    {:name => 'Серж де Гил', :account => '222444', :pass => '5193', :sum => 7500, :credit => 0, :creditsum => 0, :mail => 't-pskov_m@rambler.ru', :active => 1, :admin => 1},
    {:name => 'барон Святояр', :account => '111000', :pass => '1141', :sum => 20000, :credit => 0, :creditsum => 0, :mail => 'rt-567@yandex.ru', :active => 1, :admin => 0},
    {:name => 'баронесса', :account => '111001', :pass => '8585', :sum => 10000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'жрица Владана', :account => '111002', :pass => '6565', :sum => 20000, :credit => 0, :creditsum => 0, :mail => 'tanven@yandex.ru', :active => 1, :admin => 0},
    {:name => 'фата Ульяна', :account => '111055', :pass => '6996', :sum => 5000, :credit => 0, :creditsum => 0, :mail => 'gadziga@yandex.ru', :active => 1, :admin => 0},
    {:name => 'фата Илена', :account => '111010', :pass => '2336', :sum => 3000, :credit => 0, :creditsum => 0, :mail => 'elenkali@yandex.ru', :active => 1, :admin => 1},
    {:name => 'фея Милана', :account => '111015', :pass => '2332', :sum => 2500, :credit => 0, :creditsum => 0, :mail => 'aiflidia@yandex.ru ', :active => 1, :admin => 0},
    {:name => 'воевода Святослав', :account => '111151', :pass => '4554', :sum => 6000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'виконт Светояр', :account => '111152', :pass => '7576', :sum => 1000, :credit => 0, :creditsum => 0, :mail => 'nill-kom@yandex.ru', :active => 1, :admin => 0},
    {:name => 'ротмистр Ярослав', :account => '111153', :pass => '7745', :sum => 2000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'фея Любава', :account => '111155', :pass => '7445', :sum => 4000, :credit => 0, :creditsum => 0, :mail => 'liza.corazon@yandex.ru', :active => 1, :admin => 0},
    {:name => 'Формалин', :account => '111066', :pass => '8685', :sum => 1000, :credit => 0, :creditsum => 0, :mail => 'formalin-lin@yandex.ru', :active => 1, :admin => 0},
    {:name => 'фата Станислава', :account => '111333', :pass => '5453', :sum => 3000, :credit => 0, :creditsum => 0, :mail => 'Aiziso@mail.ru', :active => 1, :admin => 0},
    {:name => 'Никций', :account => '112112', :pass => '7788', :sum => 4000, :credit => 0, :creditsum => 0, :mail => 'ladirra@gmail.com', :active => 1, :admin => 0},
    {:name => 'Кира', :account => '113001', :pass => '9669', :sum => 3000, :credit => 0, :creditsum => 0, :mail => 'madcath@mail.ru', :active => 1, :admin => 0},
    {:name => 'Тина', :account => '113000', :pass => '3663', :sum => 2000, :credit => 0, :creditsum => 0, :mail => 'vikkkiii12@mail.ru', :active => 1, :admin => 0},
    {:name => 'Феофан', :account => '114014', :pass => '2345', :sum => 2000, :credit => 0, :creditsum => 0, :mail => 'pampagraf@gmail.com', :active => 1, :admin => 0},
    {:name => 'Эдгар На', :account => '222011', :pass => '8696', :sum => 12000, :credit => 0, :creditsum => 0, :mail => 'Jacob_stolz@yahoo.com', :active => 1, :admin => 0},
    {:name => 'Амбер На', :account => '222022', :pass => '2022', :sum => 2000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Серж ле Манн', :account => '222033', :pass => '8183', :sum => 10000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Алена ле Манн', :account => '222034', :pass => '9199', :sum => 2000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Джулия де Гил', :account => '222445', :pass => '8181', :sum => 2000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Жанна де Брии', :account => '222333', :pass => '1820', :sum => 10000, :credit => 0, :creditsum => 0, :mail => '77aurum@gmail.com', :active => 1, :admin => 0},
    {:name => 'Маркус Ололо', :account => '222626', :pass => '2012', :sum => 6000, :credit => 0, :creditsum => 0, :mail => 'samsonovivanrealne@gmail.com', :active => 1, :admin => 0},
    {:name => 'Деро', :account => '225225', :pass => '1242', :sum => 9000, :credit => 0, :creditsum => 0, :mail => 'dominus7@rambler.ru', :active => 1, :admin => 0},
    {:name => 'Бертран де Гар', :account => '222555', :pass => '1238', :sum => 15000, :credit => 0, :creditsum => 0, :mail => 'kniazpskov@mail.ru', :active => 1, :admin => 0},
    {:name => 'Стефан де Гар', :account => '222252', :pass => '1945', :sum => 6000, :credit => 0, :creditsum => 0, :mail => 'unitedevils@yandex.ru', :active => 1, :admin => 0},
    {:name => 'Изольда фон Доррет', :account => '222282', :pass => '2000', :sum => 2000, :credit => 0, :creditsum => 0, :mail => 'shatika@mail.ru', :active => 1, :admin => 0},
    {:name => 'Рорим Кумар', :account => '333000', :pass => '0022', :sum => 20000, :credit => 0, :creditsum => 0, :mail => 'dim53@yandex.ru', :active => 1, :admin => 0},
    {:name => 'Мошэ Кумар', :account => '333001', :pass => '2223', :sum => 20000, :credit => 0, :creditsum => 0, :mail => 'mosin2004@yandex.ru', :active => 1, :admin => 0},
    {:name => 'Шайлея Турчи', :account => '333033', :pass => '1151', :sum => 15000, :credit => 0, :creditsum => 0, :mail => 'yasena@yandex.ru', :active => 1, :admin => 1},
    {:name => 'Димон Хамзи', :account => '333002', :pass => '3663', :sum => 10000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Серик Турчи', :account => '333003', :pass => '3773', :sum => 10000, :credit => 0, :creditsum => 0, :mail => 'dreamltd@yandex.ru', :active => 1, :admin => 0},
    {:name => 'Дамир Турчи', :account => '333035', :pass => '5050', :sum => 8000, :credit => 0, :creditsum => 0, :mail => 'dmitry.shablov@gmail.com', :active => 1, :admin => 0},
    {:name => 'Карим Турчи', :account => '333077', :pass => '8899', :sum => 6000, :credit => 0, :creditsum => 0, :mail => 'Linkolin@inbox.ru', :active => 1, :admin => 0},
    {:name => 'Эльман Хамзи', :account => '333777', :pass => '1380', :sum => 1000, :credit => 0, :creditsum => 0, :mail => 'temnovest@list.ru', :active => 1, :admin => 0},
    {:name => 'Эльхана Хамзи', :account => '333051', :pass => '1212', :sum => 1000, :credit => 0, :creditsum => 0, :mail => 'lorajna@list.ru', :active => 1, :admin => 0},
    {:name => 'Эвиан Томба', :account => '333055', :pass => '5454', :sum => 3000, :credit => 0, :creditsum => 0, :mail => 'sameire@gmail.com', :active => 1, :admin => 0},
    {:name => 'сестра Элегиус', :account => '353053', :pass => '0333', :sum => 4000, :credit => 0, :creditsum => 0, :mail => 'lazy-ferret@mail.ru', :active => 1, :admin => 0},
    {:name => 'сестра Корвинус', :account => '353054', :pass => '0433', :sum => 2000, :credit => 0, :creditsum => 0, :mail => 'polosatij-angel@rambler.ru', :active => 1, :admin => 0},
    {:name => 'сестра Тордиус', :account => '353009', :pass => '0255', :sum => 2000, :credit => 0, :creditsum => 0, :mail => 'thordio@gmail.com', :active => 1, :admin => 0},
    {:name => 'Марк Робене', :account => '339001', :pass => '1981', :sum => 4000, :credit => 0, :creditsum => 0, :mail => 'santygo2006@mail.ru', :active => 1, :admin => 0},
    {:name => 'Радмира Робене', :account => '339002', :pass => '5858', :sum => 3000, :credit => 0, :creditsum => 0, :mail => 'kutuzova_darya@mail.ru', :active => 1, :admin => 0},
    {:name => 'Лилит Робене', :account => '339003', :pass => '9897', :sum => 3000, :credit => 0, :creditsum => 0, :mail => 'cuckoosnest@mail.ru', :active => 1, :admin => 0},
    {:name => 'Синеус Харалдссон', :account => '555050', :pass => '3030', :sum => 10000, :credit => 0, :creditsum => 0, :mail => '737sin@gmail.com', :active => 1, :admin => 0},
    {:name => 'Андрей Мясников', :account => '555033', :pass => '9595', :sum => 1000, :credit => 0, :creditsum => 0, :mail => 'mag_dead@mail.ru', :active => 1, :admin => 0},
    {:name => 'Александр Кузьмин', :account => '555045', :pass => '6968', :sum => 1000, :credit => 0, :creditsum => 0, :mail => 'panzermoon@yandex.ru', :active => 1, :admin => 0},
    {:name => 'Федор Салмин', :account => '555095', :pass => '0007', :sum => 1000, :credit => 0, :creditsum => 0, :mail => 'ursuki@mail.ru', :active => 1, :admin => 0},
    {:name => 'Михаил Клюс', :account => '555085', :pass => '0101', :sum => 2000, :credit => 0, :creditsum => 0, :mail => 'medvezhonok99@yandex.ru', :active => 1, :admin => 0},
    {:name => 'Артем Татаренко', :account => '555666', :pass => '2009', :sum => 6000, :credit => 0, :creditsum => 0, :mail => 'tatarenko12@yandex.ru', :active => 1, :admin => 0},
    {:name => 'Сергей Яковлев', :account => '555099', :pass => '0808', :sum => 1500, :credit => 0, :creditsum => 0, :mail => 'shedarius@gmail.com', :active => 1, :admin => 0},
    {:name => 'Банк Игры', :account => '000000', :pass => '9897', :sum => 1000000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Канцелярия домена Запсковье', :account => '111111', :pass => '1945', :sum => 100000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'ЗАО АКБ Велес', :account => '123123', :pass => '2055', :sum => 100000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'ЗАО АКБ Т-Банк', :account => '333333', :pass => '2066', :sum => 50000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Ломбард', :account => '303303', :pass => '2077', :sum => 5000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Обитель', :account => '353353', :pass => '6545', :sum => 0, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Аптека', :account => '353555', :pass => '7771', :sum => 0, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Универмаг Гильдии', :account => '888888', :pass => '3355', :sum => 0, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Служба утилизации', :account => '911911', :pass => '0666', :sum => 0, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'Малый тотализатор', :account => '777777', :pass => '1981', :sum => 10000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    {:name => 'ИА Т-Псков', :account => '555555', :pass => '2055', :sum => 1000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
    #{:name => '', :account => '', :pass => '', :sum => 000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
  ]
  def up
    create_table :accounts do |t|
      t.string :name
      t.string :account
      t.string :pass
      t.integer :sum
      t.integer :credit
      t.integer :creditsum
      t.string :mail
      t.integer :active
      t.integer :admin
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
    MORE_ACCOUNTS.each do |acc|
      Account.create!(acc)
    end
  end

  def down
    drop_table :accounts
  end
end
