-- Project: Bricolage Business API
-- File:    Rule.tst
-- VERSION: $Revision: 1.1 $
--
-- $Date: 2003/02/02 19:46:47 $
-- Author:  David Wheeler <david@wheeler.net>

DELETE FROM alert_type_rule;

INSERT INTO alert_type_rule (id, alert_type__id, attr, operator, value)
VALUES (1, 1, 'trig_login', 'eq', 'dwtheory');

INSERT INTO alert_type_rule (id, alert_type__id, attr, operator, value)
VALUES (2, 1, 'trig_lname', 'ne', 'Wood');

INSERT INTO alert_type_rule (id, alert_type__id, attr, operator, value)
VALUES (3, 2, 'trig_fname', 'eq', 'Garth');

INSERT INTO alert_type_rule (id, alert_type__id, attr, operator, value)
VALUES (4, 3, 'trig_lname', 'eq', 'Wheeler');

INSERT INTO alert_type_rule (id, alert_type__id, attr, operator, value)
VALUES (5, 4, 'trig_fname', 'eq', 'David');
