
ALTER TABLE poc2institution ADD CONSTRAINT poc2institution_role_fk
FOREIGN KEY (role_id)
REFERENCES role (role_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;