FROM alpine AS base

RUN apk add --no-cache curl wget

# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
RUN curl -s https://api.github.com/repos/OrchidTechnologies/orchid/releases/latest \
    | grep "browser_download_url" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | grep orchidd-lnx \
    | wget -qi -

RUN chmod +x orchidd-lnx*

FROM ubuntu

COPY --from=base /orchidd-lnx* /orchidd-lnx

CMD ["/orchidd-lnx"]