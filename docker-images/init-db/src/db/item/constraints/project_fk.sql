
ALTER TABLE item ADD CONSTRAINT provisioned_service_item_fk
FOREIGN KEY (project_id)
REFERENCES project (project_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
