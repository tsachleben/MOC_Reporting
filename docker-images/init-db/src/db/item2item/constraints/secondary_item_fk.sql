
ALTER TABLE item2item ADD CONSTRAINT item2item_secondary_item_fk
FOREIGN KEY (secondary_item)
REFERENCES item (item_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
