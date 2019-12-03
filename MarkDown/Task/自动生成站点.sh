 59 def add_site(dist, web_server, app_server, site_name, proj_path, owner):
 60     #print '%s: creating %s for %s ...' % (web_server.capitalize(), site_name)
 61     print 'deploying site "%s" ...' % (site_name)
 62
 63     site_conf = get_site_conf(web_server, site_name)
 64     if os.path.exists(site_conf):
 65         raise Exception('The site "%s" already exists!' % site_name)
 66
 67     print 'generating "%s" ...' % site_conf
 68     pattern = {'__SERVERNAME__':site_name}
 69
 70     template = 'site/' + web_server + '/'
 71     if app_server is None:
 72         template += web_server + '.conf'
 73         site_root = get_site_root(web_server, site_name)
 74     else:
 75         template += app_server + '.conf'
 76         site_root = get_site_root(app_server, site_name)
 77
 78         pattern['__BALANCER__'] = site_name.replace('.', '')
 79         if app_server == 'tomcat':
 80             pattern['__SITEDIR__'] = os.path.basename(site_root)
 81         elif web_server == 'apache' and app_server == 'wsgi':
 82             pattern['__PYTHONPATH__'] = site_root
 83
 84     pattern['__DOCROOT__'] = site_root
 85     pattern['__EMAIL__'] = '%s@%s' % (owner, '.'.join(site_name.split('.')[1:])) # FIXME
 86
 87     if not os.path.exists(template):
 88         raise Exception(template + ' dost NOT exist!')
 89
 90     base.render_to_file(site_conf, template, pattern)
 91     if os.path.basename(os.path.dirname(site_conf)) == 'sites-available':
 92         os.symlink(site_conf, site_conf.replace('sites-available', 'sites-enabled'))
 93
 94     print 'generating "%s" ...' % site_root
 95
 96     try:
 97         if proj_path is None:
 98             if not os.path.exists(site_root):
 99                 os.mkdir(site_root)
100             if app_server in ['wsgi', 'uwsgi']:
101                 os.mkdir(site_root + '/main')
102                 wsgi = site_root + '/main/wsgi.py'